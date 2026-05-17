import 'dart:io';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart' as xl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import '../core/constants.dart';
import '../core/utils.dart';
import '../core/l10n.dart';
import '../data/database.dart';

class ReportService {
  final AppDatabase _db;
  ReportService(this._db);

  Future<List<Map<String, dynamic>>> _fetchData(
      DateTime from, DateTime to, int? placeId) async {
    final items = await _db.itemsByDateAndPlace(from, to, placeId);
    final List<Map<String, dynamic>> rows = [];
    for (final item in items) {
      final sub = await _db.getSubPlace(item.subPlaceId);
      final place = await _db.placeBySubPlaceId(item.subPlaceId);
      rows.add({
        'place': place?.name ?? '-',
        'subPlace': sub.name,
        'note': item.note,
        'maintenanceType': item.maintenanceType,
        'observerName': item.observerName ?? '',
        'hasImage': item.imagePath.isNotEmpty,
        'date': item.createdAt,
      });
    }
    return rows;
  }

  String _typeDisplay(String stored, bool isArabic) {
    final t = observationTypeFromString(stored);
    if (t.isCustom && t.arabicLabel != stored) return stored;
    return isArabic ? t.arabicLabel : t.englishLabel;
  }

  Future<File> generatePdf(DateTime from, DateTime to, int? placeId,
      {bool isArabic = true}) async {
    log('PDF', 'Generating PDF report');
    final data = await _fetchData(from, to, placeId);
    final fontData = await _loadFont();
    final font = pw.Font.ttf(fontData);
    final s = AppStrings(isArabic);
    final dateStr =
        '${DateFormat('yyyy/MM/dd', 'en').format(from)} - ${DateFormat('yyyy/MM/dd', 'en').format(to)}';

    final doc = pw.Document();
    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      textDirection: isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
      header: (pw.Context ctx) => pw.Column(children: [
        pw.Text(s.inspectionReport, style: pw.TextStyle(font: font, fontSize: 18)),
        pw.SizedBox(height: 4),
        pw.Text('${s.period} $dateStr', style: pw.TextStyle(font: font, fontSize: 11, color: PdfColors.grey)),
        pw.Divider(thickness: 0.5),
      ]),
      footer: (pw.Context ctx) => pw.Text(
        '${s.inspectionReport} | ${ctx.pageNumber} / ${ctx.pagesCount}',
        style: pw.TextStyle(font: font, fontSize: 8, color: PdfColors.grey),
      ),
      build: (pw.Context ctx) => [
        if (data.isEmpty)
          pw.Center(child: pw.Text(s.noData, style: pw.TextStyle(font: font, fontSize: 14)))
        else
          pw.TableHelper.fromTextArray(
            headerStyle: pw.TextStyle(font: font, fontSize: 9, fontWeight: pw.FontWeight.bold),
            cellStyle: pw.TextStyle(font: font, fontSize: 8),
            headerAlignment: isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
            cellAlignments: {
              0: isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
              1: isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
              2: isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
              3: isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
              4: isArabic ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
              5: pw.Alignment.center,
              6: pw.Alignment.center,
            },
            headers: [
              s.place, s.subPlace, s.observations,
              s.observationTypeLabel.replaceFirst(':', ''),
              s.observerName, s.date, s.imageLabel,
            ],
            data: data.map((r) => [
              r['place'],
              r['subPlace'],
              r['note'],
              _typeDisplay(r['maintenanceType'] as String, isArabic),
              r['observerName'],
              formatDateTime(r['date'] as DateTime, locale: isArabic ? 'ar' : 'en'),
              r['hasImage'] as bool ? '✓' : '-',
            ]).toList(),
          ),
      ],
    ));

    final dir = await getTemporaryDirectory();
    final file = File(
        p.join(dir.path, 'report_${DateTime.now().millisecondsSinceEpoch}.pdf'));
    await file.writeAsBytes(await doc.save());
    log('PDF', 'Saved to ${file.path}');
    return file;
  }

  Future<File> generateExcel(DateTime from, DateTime to, int? placeId,
      {bool isArabic = true}) async {
    log('XLSX', 'Generating Excel report');
    final data = await _fetchData(from, to, placeId);
    final s = AppStrings(isArabic);
    final excel = xl.Excel.createExcel();
    final sheet = excel['Report'];

    sheet.appendRow([
      xl.TextCellValue(s.place),
      xl.TextCellValue(s.subPlace),
      xl.TextCellValue(s.observations),
      xl.TextCellValue(s.observationTypeLabel.replaceFirst(':', '')),
      xl.TextCellValue(s.observerName),
      xl.TextCellValue(s.date),
      xl.TextCellValue(s.imageLabel),
    ]);

    for (final r in data) {
      sheet.appendRow([
        xl.TextCellValue(r['place'] as String),
        xl.TextCellValue(r['subPlace'] as String),
        xl.TextCellValue(r['note'] as String),
        xl.TextCellValue(_typeDisplay(r['maintenanceType'] as String, isArabic)),
        xl.TextCellValue(r['observerName'] as String),
        xl.TextCellValue(formatDateTime(r['date'] as DateTime, locale: isArabic ? 'ar' : 'en')),
        xl.TextCellValue(r['hasImage'] as bool ? '✓' : '-'),
      ]);
    }

    final dir = await getTemporaryDirectory();
    final file = File(
        p.join(dir.path, 'report_${DateTime.now().millisecondsSinceEpoch}.xlsx'));
    final bytes = excel.encode();
    if (bytes == null) throw Exception('Excel encoding failed');
    await file.writeAsBytes(bytes);
    log('XLSX', 'Saved to ${file.path}');
    return file;
  }

  Future<void> shareFile(File file) async {
    await Printing.sharePdf(
      bytes: await file.readAsBytes(),
      filename: p.basename(file.path),
    );
  }

  Future<ByteData> _loadFont() async {
    return rootBundle.load('assets/fonts/Cairo.ttf');
  }
}
