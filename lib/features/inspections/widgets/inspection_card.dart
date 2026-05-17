import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants.dart';
import '../../../core/l10n.dart';
import '../../../core/utils.dart';
import '../../../core/locale_provider.dart';
import '../../../data/database.dart';

class InspectionCard extends ConsumerWidget {
  final InspectionItem item;
  final VoidCallback onDelete;
  const InspectionCard({super.key, required this.item, required this.onDelete});

  String _typeDisplay(ObservationType type, AppStrings strings) {
    if (type.isCustom && type.arabicLabel != item.maintenanceType) {
      return item.maintenanceType;
    }
    return strings.observationLabel(type);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = observationTypeFromString(item.maintenanceType);
    final strings = ref.watch(stringsProvider);
    final locale = ref.watch(localeProvider);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: item.imagePath.isNotEmpty ? () => _showImage(context) : null,
              child: item.imagePath.isNotEmpty
                  ? Image.file(
                      File(item.imagePath),
                      fit: BoxFit.cover,
                      errorBuilder: (_, e, s) => const Center(
                        child: Icon(Icons.broken_image, size: 48),
                      ),
                    )
                  : Center(
                      child: Icon(Icons.image_not_supported_outlined, size: 48, color: Colors.grey[400]),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.note, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12)),
                if (item.observerName != null && item.observerName!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(item.observerName!, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, color: Colors.black54)),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(type.icon, size: 14, color: type.color),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(_typeDisplay(type, strings),
                          style: TextStyle(fontSize: 11, color: type.color)),
                    ),
                    InkWell(
                      onTap: onDelete,
                      child: const Icon(Icons.delete, size: 16, color: Colors.red),
                    ),
                  ],
                ),
                Text(formatDateTime(item.createdAt, locale: locale.languageCode),
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: InteractiveViewer(
              child: Image.file(File(item.imagePath), fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
