import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils.dart';
import '../../core/locale_provider.dart';
import '../../data/database.dart';
import '../inspections/inspections_screen.dart';
import 'widgets/place_dialog.dart';

final subPlacesProvider = FutureProvider.family<List<SubPlace>, int>((ref, placeId) {
  ref.watch(refreshProvider);
  return ref.watch(dbProvider).subPlacesOf(placeId);
});

class SubPlacesScreen extends ConsumerWidget {
  final int placeId;
  final String placeName;
  const SubPlacesScreen({super.key, required this.placeId, required this.placeName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subPlaces = ref.watch(subPlacesProvider(placeId));
    final strings = ref.watch(stringsProvider);
    final locale = ref.watch(localeProvider);
    return Scaffold(
      appBar: AppBar(title: Text(placeName)),
      body: subPlaces.when(
        data: (list) => list.isEmpty
            ? Center(child: Text(strings.noSubPlaces))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: ListTile(
                    title: Text(list[i].name),
                    subtitle: Text(formatDate(list[i].createdAt, locale: locale.languageCode)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteSubPlace(context, ref, list[i].id),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InspectionsScreen(
                          subPlaceId: list[i].id,
                          subPlaceName: list[i].name,
                          placeName: placeName,
                        ),
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
        onPressed: () => _addSubPlace(context, ref),
      ),
    );
  }

  Future<void> _addSubPlace(BuildContext context, WidgetRef ref) async {
    final strings = ref.read(stringsProvider);
    final name = await showPlaceDialog(context, strings, title: strings.addSubPlace);
    if (name == null) return;
    await ref.read(dbProvider).addSubPlace(placeId, name);
    ref.invalidate(subPlacesProvider(placeId));
    ref.read(refreshProvider.notifier).trigger();
  }

  Future<void> _deleteSubPlace(BuildContext context, WidgetRef ref, int id) async {
    final strings = ref.read(stringsProvider);
    final locale = ref.read(localeProvider);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(strings.confirmDelete),
          content: Text(strings.deleteSubPlaceWarning),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(strings.cancel)),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(strings.delete)),
          ],
        ),
      ),
    );
    if (confirm != true) return;
    await ref.read(dbProvider).deleteSubPlace(id);
    ref.invalidate(subPlacesProvider(placeId));
    ref.read(refreshProvider.notifier).trigger();
  }
}
