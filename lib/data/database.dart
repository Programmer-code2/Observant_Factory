import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../core/utils.dart';

part 'database.g.dart';

final dbProvider = Provider<AppDatabase>((ref) => AppDatabase());

class RefreshNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void trigger() => state++;
}

final refreshProvider = NotifierProvider<RefreshNotifier, int>(RefreshNotifier.new);

class Places extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  DateTimeColumn get createdAt => dateTime()();
}

class SubPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get placeId => integer()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  DateTimeColumn get createdAt => dateTime()();
}

class InspectionItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subPlaceId => integer()();
  TextColumn get imagePath => text()();
  TextColumn get note => text()();
  TextColumn get maintenanceType => text()();
  TextColumn? get observerName => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [Places, SubPlaces, InspectionItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(inspectionItems, inspectionItems.observerName);
      }
    },
  );

  Future<List<Place>> allPlaces() => select(places).get();
  Future<Place> getPlace(int id) =>
      (select(places)..where((t) => t.id.equals(id))).getSingle();
  Future<int> addPlace(String name) =>
      into(places).insert(PlacesCompanion.insert(name: name, createdAt: DateTime.now()));
  Future<void> updatePlace(int id, String name) =>
      (update(places)..where((t) => t.id.equals(id))).write(PlacesCompanion(name: Value(name)));
  Future<void> deletePlace(int id) async {
    final subs = await subPlacesOf(id);
    for (final sub in subs) {
      await deleteSubPlace(sub.id);
    }
    (delete(places)..where((t) => t.id.equals(id))).go();
  }

  Future<List<SubPlace>> subPlacesOf(int placeId) =>
      (select(subPlaces)..where((t) => t.placeId.equals(placeId))).get();
  Future<int> addSubPlace(int placeId, String name) =>
      into(subPlaces).insert(SubPlacesCompanion.insert(placeId: placeId, name: name, createdAt: DateTime.now()));
  Future<void> deleteSubPlace(int id) async {
    final items = await itemsOf(id);
    for (final item in items) {
      await deleteItem(item.id);
    }
    (delete(subPlaces)..where((t) => t.id.equals(id))).go();
  }

  Future<List<InspectionItem>> itemsOf(int subPlaceId) =>
      (select(inspectionItems)..where((t) => t.subPlaceId.equals(subPlaceId))).get();
  Future<int> addItem(int subPlaceId, String imagePath, String note, String maintenanceType, {String? observerName}) =>
      into(inspectionItems).insert(InspectionItemsCompanion.insert(
        subPlaceId: subPlaceId, imagePath: imagePath, note: note, maintenanceType: maintenanceType, createdAt: DateTime.now()));

  Future<InspectionItem?> getItem(int id) async {
    final result = await (select(inspectionItems)..where((t) => t.id.equals(id))).get();
    return result.isEmpty ? null : result.first;
  }

  Future<void> deleteItem(int id) async {
    final item = await getItem(id);
    if (item != null && item.imagePath.isNotEmpty) {
      final f = File(item.imagePath);
      if (await f.exists()) await f.delete();
    }
    (delete(inspectionItems)..where((t) => t.id.equals(id))).go();
  }

  Future<List<InspectionItem>> itemsByDateAndPlace(DateTime from, DateTime to, int? placeId) async {
    final allItems = await (select(inspectionItems)
        ..where((t) => t.createdAt.isBetweenValues(from, to))).get();
    if (placeId == null) return allItems;
    final subIds = (await subPlacesOf(placeId)).map((s) => s.id).toSet();
    return allItems.where((i) => subIds.contains(i.subPlaceId)).toList();
  }

  Future<SubPlace> getSubPlace(int id) =>
      (select(subPlaces)..where((t) => t.id.equals(id))).getSingle();
  Future<List<InspectionItem>> allItems() => select(inspectionItems).get();

  Future<Place?> placeBySubPlaceId(int subPlaceId) async {
    final sub = await getSubPlace(subPlaceId);
    return getPlace(sub.placeId);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'observant_factory.db'));
    log('DB', 'Opening database at ${file.path}');
    return NativeDatabase(file);
  });
}
