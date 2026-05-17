import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/locale_provider.dart';
import '../../data/database.dart';
import '../inspections/widgets/inspection_card.dart';

final allObservationsProvider = FutureProvider<List<InspectionItem>>((ref) {
  ref.watch(refreshProvider);
  return ref.watch(dbProvider).allItems();
});

class ObservationsScreen extends ConsumerWidget {
  const ObservationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(allObservationsProvider);
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(strings.allObservations)),
      body: items.when(
        data: (list) => list.isEmpty
            ? Center(child: Text(strings.noObservations))
            : GridView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemCount: list.length,
                itemBuilder: (_, i) => InspectionCard(
                  item: list[i],
                  onDelete: () => _deleteItem(ref, list[i]),
                ),
              ),
        error: (e, _) => Center(child: Text('${strings.error} $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> _deleteItem(WidgetRef ref, InspectionItem item) async {
    await ref.read(dbProvider).deleteItem(item.id);
    ref.invalidate(allObservationsProvider);
    ref.read(refreshProvider.notifier).trigger();
  }
}
