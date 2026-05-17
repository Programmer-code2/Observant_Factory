import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/l10n.dart';
import '../../core/utils.dart';
import '../../core/locale_provider.dart';
import '../../data/database.dart';

final dashboardDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  ref.watch(refreshProvider);
  final db = ref.watch(dbProvider);
  final allItems = await db.allItems();
  final allPlaces = await db.allPlaces();
  final itemsBySubPlace = <int, List<InspectionItem>>{};
  for (final item in allItems) {
    itemsBySubPlace.putIfAbsent(item.subPlaceId, () => []).add(item);
  }
  final typeCount = <String, int>{};
  for (final item in allItems) {
    final t = observationTypeFromString(item.maintenanceType);
    final key = t.isCustom && t.arabicLabel != item.maintenanceType
        ? item.maintenanceType
        : t.arabicLabel;
    typeCount[key] = (typeCount[key] ?? 0) + 1;
  }
  final recent = allItems.reversed.take(10).toList();
  return {
    'items': allItems,
    'places': allPlaces,
    'typeCount': typeCount,
    'recent': recent,
    'itemsBySubPlace': itemsBySubPlace,
  };
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dashboardDataProvider);
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(strings.navDashboard)),
      body: data.when(
        data: (d) {
          final items = d['items'] as List<InspectionItem>;
          final places = d['places'] as List<Place>;
          final typeCount = d['typeCount'] as Map<String, int>;
          final recent = d['recent'] as List<InspectionItem>;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            children: [
              _StatRow(items: items.length, places: places.length, strings: strings),
              const SizedBox(height: 20),
              Text(strings.byType, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _TypeGrid(typeCount: typeCount),
              const SizedBox(height: 20),
              Text(strings.recentActivity, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...recent.map((item) => _RecentTile(item: item)),
              if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(child: Text(strings.noObservations, style: const TextStyle(color: Colors.grey))),
              ),
            ],
          );
        },
        error: (e, _) => Center(child: Text('$e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final int items;
  final int places;
  final AppStrings strings;
  const _StatRow({required this.items, required this.places, required this.strings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Icon(Icons.visibility, size: 32, color: theme.colorScheme.primary),
                  const SizedBox(height: 8),
                  Text('$items', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text(strings.observations, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Icon(Icons.business, size: 32, color: theme.colorScheme.tertiary),
                  const SizedBox(height: 8),
                  Text('$places', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text(strings.navPlaces, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TypeGrid extends StatelessWidget {
  final Map<String, int> typeCount;
  const _TypeGrid({required this.typeCount});

  @override
  Widget build(BuildContext context) {
    final entries = typeCount.entries.toList();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: entries.map((e) {
        final type = observationTypeFromString(e.key);
        final color = type.isCustom && type.arabicLabel != e.key ? Colors.grey : type.color;
        return IntrinsicWidth(
          child: Card(
            color: color.withValues(alpha: 0.08),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(type.icon, size: 18, color: color),
                  const SizedBox(width: 6),
                  Text(e.key, style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('${e.value}', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _RecentTile extends ConsumerWidget {
  final InspectionItem item;
  const _RecentTile({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = observationTypeFromString(item.maintenanceType);
    final locale = ref.watch(localeProvider);
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: type.color.withValues(alpha: 0.15),
          child: Icon(type.icon, size: 18, color: type.color),
        ),
        title: Text(item.note, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Text(
          formatDateTime(item.createdAt, locale: locale.languageCode),
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ),
    );
  }
}
