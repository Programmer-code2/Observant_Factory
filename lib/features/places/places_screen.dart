import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils.dart';
import '../../core/locale_provider.dart';
import '../../data/database.dart';
import 'sub_places_screen.dart';
import 'widgets/place_dialog.dart';

final placesProvider = FutureProvider<List<Place>>((ref) {
  ref.watch(refreshProvider);
  return ref.watch(dbProvider).allPlaces();
});

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.mainPlaces),
      ),
      body: places.when(
        data: (list) => list.isEmpty
            ? Center(child: Text(strings.noPlaces))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: ListTile(
                    title: Text(list[i].name),
                    subtitle: Text(formatDate(list[i].createdAt, locale: ref.read(localeProvider).languageCode)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deletePlace(context, ref, list[i].id),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubPlacesScreen(placeId: list[i].id, placeName: list[i].name),
                      ),
                    ),
                  ),
                ),
              ),
        error: (e, _) => Center(child: Text('${strings.error} $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addPlace(context, ref),
      ),
    );
  }

  Future<void> _addPlace(BuildContext context, WidgetRef ref) async {
    final strings = ref.read(stringsProvider);
    final name = await showPlaceDialog(context, strings, title: strings.addPlace);
    if (name == null) return;
    await ref.read(dbProvider).addPlace(name);
    ref.invalidate(placesProvider);
    ref.read(refreshProvider.notifier).trigger();
  }

  Future<void> _deletePlace(BuildContext context, WidgetRef ref, int id) async {
    final strings = ref.read(stringsProvider);
    final locale = ref.read(localeProvider);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(strings.confirmDelete),
          content: Text(strings.deletePlaceWarning),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(strings.cancel)),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(strings.delete)),
          ],
        ),
      ),
    );
    if (confirm != true) return;
    await ref.read(dbProvider).deletePlace(id);
    ref.invalidate(placesProvider);
    ref.read(refreshProvider.notifier).trigger();
  }
}
