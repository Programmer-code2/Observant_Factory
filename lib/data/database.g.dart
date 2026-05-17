// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(
    Insertable<Place> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Place(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(attachedDatabase, alias);
  }
}

class Place extends DataClass implements Insertable<Place> {
  final int id;
  final String name;
  final DateTime createdAt;
  const Place({required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlacesCompanion toCompanion(bool nullToAbsent) {
    return PlacesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Place.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Place(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Place copyWith({int? id, String? name, DateTime? createdAt}) => Place(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  Place copyWithCompanion(PlacesCompanion data) {
    return Place(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Place(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Place &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Place> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlacesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SubPlacesTable extends SubPlaces
    with TableInfo<$SubPlacesTable, SubPlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubPlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, placeId, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sub_places';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubPlace> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubPlace(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}place_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SubPlacesTable createAlias(String alias) {
    return $SubPlacesTable(attachedDatabase, alias);
  }
}

class SubPlace extends DataClass implements Insertable<SubPlace> {
  final int id;
  final int placeId;
  final String name;
  final DateTime createdAt;
  const SubPlace({
    required this.id,
    required this.placeId,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SubPlacesCompanion toCompanion(bool nullToAbsent) {
    return SubPlacesCompanion(
      id: Value(id),
      placeId: Value(placeId),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory SubPlace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubPlace(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SubPlace copyWith({
    int? id,
    int? placeId,
    String? name,
    DateTime? createdAt,
  }) => SubPlace(
    id: id ?? this.id,
    placeId: placeId ?? this.placeId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  SubPlace copyWithCompanion(SubPlacesCompanion data) {
    return SubPlace(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubPlace(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubPlace &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class SubPlacesCompanion extends UpdateCompanion<SubPlace> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const SubPlacesCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SubPlacesCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required String name,
    required DateTime createdAt,
  }) : placeId = Value(placeId),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<SubPlace> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SubPlacesCompanion copyWith({
    Value<int>? id,
    Value<int>? placeId,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return SubPlacesCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubPlacesCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InspectionItemsTable extends InspectionItems
    with TableInfo<$InspectionItemsTable, InspectionItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _subPlaceIdMeta = const VerificationMeta(
    'subPlaceId',
  );
  @override
  late final GeneratedColumn<int> subPlaceId = GeneratedColumn<int>(
    'sub_place_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maintenanceTypeMeta = const VerificationMeta(
    'maintenanceType',
  );
  @override
  late final GeneratedColumn<String> maintenanceType = GeneratedColumn<String>(
    'maintenance_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _observerNameMeta = const VerificationMeta(
    'observerName',
  );
  @override
  late final GeneratedColumn<String> observerName = GeneratedColumn<String>(
    'observer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subPlaceId,
    imagePath,
    note,
    maintenanceType,
    observerName,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspection_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sub_place_id')) {
      context.handle(
        _subPlaceIdMeta,
        subPlaceId.isAcceptableOrUnknown(
          data['sub_place_id']!,
          _subPlaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subPlaceIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('maintenance_type')) {
      context.handle(
        _maintenanceTypeMeta,
        maintenanceType.isAcceptableOrUnknown(
          data['maintenance_type']!,
          _maintenanceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maintenanceTypeMeta);
    }
    if (data.containsKey('observer_name')) {
      context.handle(
        _observerNameMeta,
        observerName.isAcceptableOrUnknown(
          data['observer_name']!,
          _observerNameMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspectionItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subPlaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_place_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      maintenanceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maintenance_type'],
      )!,
      observerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observer_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InspectionItemsTable createAlias(String alias) {
    return $InspectionItemsTable(attachedDatabase, alias);
  }
}

class InspectionItem extends DataClass implements Insertable<InspectionItem> {
  final int id;
  final int subPlaceId;
  final String imagePath;
  final String note;
  final String maintenanceType;
  final String? observerName;
  final DateTime createdAt;
  const InspectionItem({
    required this.id,
    required this.subPlaceId,
    required this.imagePath,
    required this.note,
    required this.maintenanceType,
    this.observerName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sub_place_id'] = Variable<int>(subPlaceId);
    map['image_path'] = Variable<String>(imagePath);
    map['note'] = Variable<String>(note);
    map['maintenance_type'] = Variable<String>(maintenanceType);
    if (!nullToAbsent || observerName != null) {
      map['observer_name'] = Variable<String>(observerName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InspectionItemsCompanion toCompanion(bool nullToAbsent) {
    return InspectionItemsCompanion(
      id: Value(id),
      subPlaceId: Value(subPlaceId),
      imagePath: Value(imagePath),
      note: Value(note),
      maintenanceType: Value(maintenanceType),
      observerName: observerName == null && nullToAbsent
          ? const Value.absent()
          : Value(observerName),
      createdAt: Value(createdAt),
    );
  }

  factory InspectionItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionItem(
      id: serializer.fromJson<int>(json['id']),
      subPlaceId: serializer.fromJson<int>(json['subPlaceId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      note: serializer.fromJson<String>(json['note']),
      maintenanceType: serializer.fromJson<String>(json['maintenanceType']),
      observerName: serializer.fromJson<String?>(json['observerName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subPlaceId': serializer.toJson<int>(subPlaceId),
      'imagePath': serializer.toJson<String>(imagePath),
      'note': serializer.toJson<String>(note),
      'maintenanceType': serializer.toJson<String>(maintenanceType),
      'observerName': serializer.toJson<String?>(observerName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InspectionItem copyWith({
    int? id,
    int? subPlaceId,
    String? imagePath,
    String? note,
    String? maintenanceType,
    Value<String?> observerName = const Value.absent(),
    DateTime? createdAt,
  }) => InspectionItem(
    id: id ?? this.id,
    subPlaceId: subPlaceId ?? this.subPlaceId,
    imagePath: imagePath ?? this.imagePath,
    note: note ?? this.note,
    maintenanceType: maintenanceType ?? this.maintenanceType,
    observerName: observerName.present ? observerName.value : this.observerName,
    createdAt: createdAt ?? this.createdAt,
  );
  InspectionItem copyWithCompanion(InspectionItemsCompanion data) {
    return InspectionItem(
      id: data.id.present ? data.id.value : this.id,
      subPlaceId: data.subPlaceId.present
          ? data.subPlaceId.value
          : this.subPlaceId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      note: data.note.present ? data.note.value : this.note,
      maintenanceType: data.maintenanceType.present
          ? data.maintenanceType.value
          : this.maintenanceType,
      observerName: data.observerName.present
          ? data.observerName.value
          : this.observerName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionItem(')
          ..write('id: $id, ')
          ..write('subPlaceId: $subPlaceId, ')
          ..write('imagePath: $imagePath, ')
          ..write('note: $note, ')
          ..write('maintenanceType: $maintenanceType, ')
          ..write('observerName: $observerName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subPlaceId,
    imagePath,
    note,
    maintenanceType,
    observerName,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionItem &&
          other.id == this.id &&
          other.subPlaceId == this.subPlaceId &&
          other.imagePath == this.imagePath &&
          other.note == this.note &&
          other.maintenanceType == this.maintenanceType &&
          other.observerName == this.observerName &&
          other.createdAt == this.createdAt);
}

class InspectionItemsCompanion extends UpdateCompanion<InspectionItem> {
  final Value<int> id;
  final Value<int> subPlaceId;
  final Value<String> imagePath;
  final Value<String> note;
  final Value<String> maintenanceType;
  final Value<String?> observerName;
  final Value<DateTime> createdAt;
  const InspectionItemsCompanion({
    this.id = const Value.absent(),
    this.subPlaceId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.note = const Value.absent(),
    this.maintenanceType = const Value.absent(),
    this.observerName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InspectionItemsCompanion.insert({
    this.id = const Value.absent(),
    required int subPlaceId,
    required String imagePath,
    required String note,
    required String maintenanceType,
    this.observerName = const Value.absent(),
    required DateTime createdAt,
  }) : subPlaceId = Value(subPlaceId),
       imagePath = Value(imagePath),
       note = Value(note),
       maintenanceType = Value(maintenanceType),
       createdAt = Value(createdAt);
  static Insertable<InspectionItem> custom({
    Expression<int>? id,
    Expression<int>? subPlaceId,
    Expression<String>? imagePath,
    Expression<String>? note,
    Expression<String>? maintenanceType,
    Expression<String>? observerName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subPlaceId != null) 'sub_place_id': subPlaceId,
      if (imagePath != null) 'image_path': imagePath,
      if (note != null) 'note': note,
      if (maintenanceType != null) 'maintenance_type': maintenanceType,
      if (observerName != null) 'observer_name': observerName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InspectionItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? subPlaceId,
    Value<String>? imagePath,
    Value<String>? note,
    Value<String>? maintenanceType,
    Value<String?>? observerName,
    Value<DateTime>? createdAt,
  }) {
    return InspectionItemsCompanion(
      id: id ?? this.id,
      subPlaceId: subPlaceId ?? this.subPlaceId,
      imagePath: imagePath ?? this.imagePath,
      note: note ?? this.note,
      maintenanceType: maintenanceType ?? this.maintenanceType,
      observerName: observerName ?? this.observerName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subPlaceId.present) {
      map['sub_place_id'] = Variable<int>(subPlaceId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (maintenanceType.present) {
      map['maintenance_type'] = Variable<String>(maintenanceType.value);
    }
    if (observerName.present) {
      map['observer_name'] = Variable<String>(observerName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionItemsCompanion(')
          ..write('id: $id, ')
          ..write('subPlaceId: $subPlaceId, ')
          ..write('imagePath: $imagePath, ')
          ..write('note: $note, ')
          ..write('maintenanceType: $maintenanceType, ')
          ..write('observerName: $observerName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlacesTable places = $PlacesTable(this);
  late final $SubPlacesTable subPlaces = $SubPlacesTable(this);
  late final $InspectionItemsTable inspectionItems = $InspectionItemsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    places,
    subPlaces,
    inspectionItems,
  ];
}

typedef $$PlacesTableCreateCompanionBuilder =
    PlacesCompanion Function({
      Value<int> id,
      required String name,
      required DateTime createdAt,
    });
typedef $$PlacesTableUpdateCompanionBuilder =
    PlacesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
    });

class $$PlacesTableFilterComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlacesTable,
          Place,
          $$PlacesTableFilterComposer,
          $$PlacesTableOrderingComposer,
          $$PlacesTableAnnotationComposer,
          $$PlacesTableCreateCompanionBuilder,
          $$PlacesTableUpdateCompanionBuilder,
          (Place, BaseReferences<_$AppDatabase, $PlacesTable, Place>),
          Place,
          PrefetchHooks Function()
        > {
  $$PlacesTableTableManager(_$AppDatabase db, $PlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlacesCompanion(id: id, name: name, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime createdAt,
              }) => PlacesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlacesTable,
      Place,
      $$PlacesTableFilterComposer,
      $$PlacesTableOrderingComposer,
      $$PlacesTableAnnotationComposer,
      $$PlacesTableCreateCompanionBuilder,
      $$PlacesTableUpdateCompanionBuilder,
      (Place, BaseReferences<_$AppDatabase, $PlacesTable, Place>),
      Place,
      PrefetchHooks Function()
    >;
typedef $$SubPlacesTableCreateCompanionBuilder =
    SubPlacesCompanion Function({
      Value<int> id,
      required int placeId,
      required String name,
      required DateTime createdAt,
    });
typedef $$SubPlacesTableUpdateCompanionBuilder =
    SubPlacesCompanion Function({
      Value<int> id,
      Value<int> placeId,
      Value<String> name,
      Value<DateTime> createdAt,
    });

class $$SubPlacesTableFilterComposer
    extends Composer<_$AppDatabase, $SubPlacesTable> {
  $$SubPlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubPlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $SubPlacesTable> {
  $$SubPlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubPlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubPlacesTable> {
  $$SubPlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get placeId =>
      $composableBuilder(column: $table.placeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SubPlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubPlacesTable,
          SubPlace,
          $$SubPlacesTableFilterComposer,
          $$SubPlacesTableOrderingComposer,
          $$SubPlacesTableAnnotationComposer,
          $$SubPlacesTableCreateCompanionBuilder,
          $$SubPlacesTableUpdateCompanionBuilder,
          (SubPlace, BaseReferences<_$AppDatabase, $SubPlacesTable, SubPlace>),
          SubPlace,
          PrefetchHooks Function()
        > {
  $$SubPlacesTableTableManager(_$AppDatabase db, $SubPlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubPlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubPlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubPlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> placeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SubPlacesCompanion(
                id: id,
                placeId: placeId,
                name: name,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int placeId,
                required String name,
                required DateTime createdAt,
              }) => SubPlacesCompanion.insert(
                id: id,
                placeId: placeId,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubPlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubPlacesTable,
      SubPlace,
      $$SubPlacesTableFilterComposer,
      $$SubPlacesTableOrderingComposer,
      $$SubPlacesTableAnnotationComposer,
      $$SubPlacesTableCreateCompanionBuilder,
      $$SubPlacesTableUpdateCompanionBuilder,
      (SubPlace, BaseReferences<_$AppDatabase, $SubPlacesTable, SubPlace>),
      SubPlace,
      PrefetchHooks Function()
    >;
typedef $$InspectionItemsTableCreateCompanionBuilder =
    InspectionItemsCompanion Function({
      Value<int> id,
      required int subPlaceId,
      required String imagePath,
      required String note,
      required String maintenanceType,
      Value<String?> observerName,
      required DateTime createdAt,
    });
typedef $$InspectionItemsTableUpdateCompanionBuilder =
    InspectionItemsCompanion Function({
      Value<int> id,
      Value<int> subPlaceId,
      Value<String> imagePath,
      Value<String> note,
      Value<String> maintenanceType,
      Value<String?> observerName,
      Value<DateTime> createdAt,
    });

class $$InspectionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionItemsTable> {
  $$InspectionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subPlaceId => $composableBuilder(
    column: $table.subPlaceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maintenanceType => $composableBuilder(
    column: $table.maintenanceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observerName => $composableBuilder(
    column: $table.observerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionItemsTable> {
  $$InspectionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subPlaceId => $composableBuilder(
    column: $table.subPlaceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maintenanceType => $composableBuilder(
    column: $table.maintenanceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observerName => $composableBuilder(
    column: $table.observerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionItemsTable> {
  $$InspectionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get subPlaceId => $composableBuilder(
    column: $table.subPlaceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get maintenanceType => $composableBuilder(
    column: $table.maintenanceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observerName => $composableBuilder(
    column: $table.observerName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$InspectionItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionItemsTable,
          InspectionItem,
          $$InspectionItemsTableFilterComposer,
          $$InspectionItemsTableOrderingComposer,
          $$InspectionItemsTableAnnotationComposer,
          $$InspectionItemsTableCreateCompanionBuilder,
          $$InspectionItemsTableUpdateCompanionBuilder,
          (
            InspectionItem,
            BaseReferences<
              _$AppDatabase,
              $InspectionItemsTable,
              InspectionItem
            >,
          ),
          InspectionItem,
          PrefetchHooks Function()
        > {
  $$InspectionItemsTableTableManager(
    _$AppDatabase db,
    $InspectionItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subPlaceId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String> maintenanceType = const Value.absent(),
                Value<String?> observerName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InspectionItemsCompanion(
                id: id,
                subPlaceId: subPlaceId,
                imagePath: imagePath,
                note: note,
                maintenanceType: maintenanceType,
                observerName: observerName,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subPlaceId,
                required String imagePath,
                required String note,
                required String maintenanceType,
                Value<String?> observerName = const Value.absent(),
                required DateTime createdAt,
              }) => InspectionItemsCompanion.insert(
                id: id,
                subPlaceId: subPlaceId,
                imagePath: imagePath,
                note: note,
                maintenanceType: maintenanceType,
                observerName: observerName,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionItemsTable,
      InspectionItem,
      $$InspectionItemsTableFilterComposer,
      $$InspectionItemsTableOrderingComposer,
      $$InspectionItemsTableAnnotationComposer,
      $$InspectionItemsTableCreateCompanionBuilder,
      $$InspectionItemsTableUpdateCompanionBuilder,
      (
        InspectionItem,
        BaseReferences<_$AppDatabase, $InspectionItemsTable, InspectionItem>,
      ),
      InspectionItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlacesTableTableManager get places =>
      $$PlacesTableTableManager(_db, _db.places);
  $$SubPlacesTableTableManager get subPlaces =>
      $$SubPlacesTableTableManager(_db, _db.subPlaces);
  $$InspectionItemsTableTableManager get inspectionItems =>
      $$InspectionItemsTableTableManager(_db, _db.inspectionItems);
}
