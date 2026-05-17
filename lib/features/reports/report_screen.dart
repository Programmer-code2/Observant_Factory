import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils.dart';
import '../../core/locale_provider.dart';
import '../../data/database.dart';
import '../../services/report_service.dart';
import '../places/places_screen.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  DateTime _from = DateTime.now().subtract(const Duration(days: 30));
  DateTime _to = DateTime.now();
  int? _selectedPlaceId;
  bool _generating = false;

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(strings.reports)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _dateField(strings.fromDate, _from, (d) {
            if (d != null) setState(() => _from = d);
          }),
          const SizedBox(height: 12),
          _dateField(strings.toDate, _to, (d) {
            if (d != null) setState(() => _to = d);
          }),
          const SizedBox(height: 16),
          places.when(
            data: (list) => DropdownButtonFormField<int?>(
              initialValue: _selectedPlaceId,
              decoration: InputDecoration(
                labelText: strings.placeOptional,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(strings.all)),
                ...list.map((p) => DropdownMenuItem(
                      value: p.id,
                      child: Text(p.name),
                    )),
              ],
              onChanged: (v) => setState(() => _selectedPlaceId = v),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('${strings.error} $e'),
          ),
          const SizedBox(height: 32),
          _generating
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _generate('pdf'),
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text('PDF'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _generate('xlsx'),
                        icon: const Icon(Icons.table_chart),
                        label: const Text('Excel'),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _dateField(String label, DateTime value, ValueChanged<DateTime?> onPick) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) onPick(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(formatDate(value)),
      ),
    );
  }

  Future<void> _generate(String format) async {
    final strings = ref.read(stringsProvider);
    if (_from.isAfter(_to)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.dateRangeError)),
      );
      return;
    }
    setState(() => _generating = true);
    try {
      final isArabic = ref.read(localeProvider).languageCode == 'ar';
      final service = ReportService(ref.read(dbProvider));
      File file;
      if (format == 'pdf') {
        file = await service.generatePdf(_from, _to, _selectedPlaceId, isArabic: isArabic);
      } else {
        file = await service.generateExcel(_from, _to, _selectedPlaceId, isArabic: isArabic);
      }
      if (!mounted) return;
      await service.shareFile(file);
      log('REPORT', 'Report generated: ${file.path}');
    } catch (e) {
      log('REPORT', 'Failed: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${strings.reportFailed} $e')),
      );
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }
}
