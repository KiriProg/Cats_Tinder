// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CatEntitiesTable extends CatEntities
    with TableInfo<$CatEntitiesTable, CatEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
      'breed', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _temperamentMeta =
      const VerificationMeta('temperament');
  @override
  late final GeneratedColumn<String> temperament = GeneratedColumn<String>(
      'temperament', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lifeSpanMeta =
      const VerificationMeta('lifeSpan');
  @override
  late final GeneratedColumn<String> lifeSpan = GeneratedColumn<String>(
      'life_span', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wikipediaUrlMeta =
      const VerificationMeta('wikipediaUrl');
  @override
  late final GeneratedColumn<String> wikipediaUrl = GeneratedColumn<String>(
      'wikipedia_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        imageUrl,
        breed,
        description,
        temperament,
        origin,
        lifeSpan,
        wikipediaUrl
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cat_entities';
  @override
  VerificationContext validateIntegrity(Insertable<CatEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
          _breedMeta, breed.isAcceptableOrUnknown(data['breed']!, _breedMeta));
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('temperament')) {
      context.handle(
          _temperamentMeta,
          temperament.isAcceptableOrUnknown(
              data['temperament']!, _temperamentMeta));
    } else if (isInserting) {
      context.missing(_temperamentMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('life_span')) {
      context.handle(_lifeSpanMeta,
          lifeSpan.isAcceptableOrUnknown(data['life_span']!, _lifeSpanMeta));
    } else if (isInserting) {
      context.missing(_lifeSpanMeta);
    }
    if (data.containsKey('wikipedia_url')) {
      context.handle(
          _wikipediaUrlMeta,
          wikipediaUrl.isAcceptableOrUnknown(
              data['wikipedia_url']!, _wikipediaUrlMeta));
    } else if (isInserting) {
      context.missing(_wikipediaUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {imageUrl};
  @override
  CatEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatEntity(
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      breed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}breed'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      temperament: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}temperament'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      lifeSpan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}life_span'])!,
      wikipediaUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wikipedia_url'])!,
    );
  }

  @override
  $CatEntitiesTable createAlias(String alias) {
    return $CatEntitiesTable(attachedDatabase, alias);
  }
}

class CatEntity extends DataClass implements Insertable<CatEntity> {
  final String imageUrl;
  final String breed;
  final String description;
  final String temperament;
  final String origin;
  final String lifeSpan;
  final String wikipediaUrl;
  const CatEntity(
      {required this.imageUrl,
      required this.breed,
      required this.description,
      required this.temperament,
      required this.origin,
      required this.lifeSpan,
      required this.wikipediaUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['image_url'] = Variable<String>(imageUrl);
    map['breed'] = Variable<String>(breed);
    map['description'] = Variable<String>(description);
    map['temperament'] = Variable<String>(temperament);
    map['origin'] = Variable<String>(origin);
    map['life_span'] = Variable<String>(lifeSpan);
    map['wikipedia_url'] = Variable<String>(wikipediaUrl);
    return map;
  }

  CatEntitiesCompanion toCompanion(bool nullToAbsent) {
    return CatEntitiesCompanion(
      imageUrl: Value(imageUrl),
      breed: Value(breed),
      description: Value(description),
      temperament: Value(temperament),
      origin: Value(origin),
      lifeSpan: Value(lifeSpan),
      wikipediaUrl: Value(wikipediaUrl),
    );
  }

  factory CatEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatEntity(
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      breed: serializer.fromJson<String>(json['breed']),
      description: serializer.fromJson<String>(json['description']),
      temperament: serializer.fromJson<String>(json['temperament']),
      origin: serializer.fromJson<String>(json['origin']),
      lifeSpan: serializer.fromJson<String>(json['lifeSpan']),
      wikipediaUrl: serializer.fromJson<String>(json['wikipediaUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'imageUrl': serializer.toJson<String>(imageUrl),
      'breed': serializer.toJson<String>(breed),
      'description': serializer.toJson<String>(description),
      'temperament': serializer.toJson<String>(temperament),
      'origin': serializer.toJson<String>(origin),
      'lifeSpan': serializer.toJson<String>(lifeSpan),
      'wikipediaUrl': serializer.toJson<String>(wikipediaUrl),
    };
  }

  CatEntity copyWith(
          {String? imageUrl,
          String? breed,
          String? description,
          String? temperament,
          String? origin,
          String? lifeSpan,
          String? wikipediaUrl}) =>
      CatEntity(
        imageUrl: imageUrl ?? this.imageUrl,
        breed: breed ?? this.breed,
        description: description ?? this.description,
        temperament: temperament ?? this.temperament,
        origin: origin ?? this.origin,
        lifeSpan: lifeSpan ?? this.lifeSpan,
        wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
      );
  CatEntity copyWithCompanion(CatEntitiesCompanion data) {
    return CatEntity(
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      breed: data.breed.present ? data.breed.value : this.breed,
      description:
          data.description.present ? data.description.value : this.description,
      temperament:
          data.temperament.present ? data.temperament.value : this.temperament,
      origin: data.origin.present ? data.origin.value : this.origin,
      lifeSpan: data.lifeSpan.present ? data.lifeSpan.value : this.lifeSpan,
      wikipediaUrl: data.wikipediaUrl.present
          ? data.wikipediaUrl.value
          : this.wikipediaUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatEntity(')
          ..write('imageUrl: $imageUrl, ')
          ..write('breed: $breed, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin, ')
          ..write('lifeSpan: $lifeSpan, ')
          ..write('wikipediaUrl: $wikipediaUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(imageUrl, breed, description, temperament,
      origin, lifeSpan, wikipediaUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatEntity &&
          other.imageUrl == this.imageUrl &&
          other.breed == this.breed &&
          other.description == this.description &&
          other.temperament == this.temperament &&
          other.origin == this.origin &&
          other.lifeSpan == this.lifeSpan &&
          other.wikipediaUrl == this.wikipediaUrl);
}

class CatEntitiesCompanion extends UpdateCompanion<CatEntity> {
  final Value<String> imageUrl;
  final Value<String> breed;
  final Value<String> description;
  final Value<String> temperament;
  final Value<String> origin;
  final Value<String> lifeSpan;
  final Value<String> wikipediaUrl;
  final Value<int> rowid;
  const CatEntitiesCompanion({
    this.imageUrl = const Value.absent(),
    this.breed = const Value.absent(),
    this.description = const Value.absent(),
    this.temperament = const Value.absent(),
    this.origin = const Value.absent(),
    this.lifeSpan = const Value.absent(),
    this.wikipediaUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatEntitiesCompanion.insert({
    required String imageUrl,
    required String breed,
    required String description,
    required String temperament,
    required String origin,
    required String lifeSpan,
    required String wikipediaUrl,
    this.rowid = const Value.absent(),
  })  : imageUrl = Value(imageUrl),
        breed = Value(breed),
        description = Value(description),
        temperament = Value(temperament),
        origin = Value(origin),
        lifeSpan = Value(lifeSpan),
        wikipediaUrl = Value(wikipediaUrl);
  static Insertable<CatEntity> custom({
    Expression<String>? imageUrl,
    Expression<String>? breed,
    Expression<String>? description,
    Expression<String>? temperament,
    Expression<String>? origin,
    Expression<String>? lifeSpan,
    Expression<String>? wikipediaUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (imageUrl != null) 'image_url': imageUrl,
      if (breed != null) 'breed': breed,
      if (description != null) 'description': description,
      if (temperament != null) 'temperament': temperament,
      if (origin != null) 'origin': origin,
      if (lifeSpan != null) 'life_span': lifeSpan,
      if (wikipediaUrl != null) 'wikipedia_url': wikipediaUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatEntitiesCompanion copyWith(
      {Value<String>? imageUrl,
      Value<String>? breed,
      Value<String>? description,
      Value<String>? temperament,
      Value<String>? origin,
      Value<String>? lifeSpan,
      Value<String>? wikipediaUrl,
      Value<int>? rowid}) {
    return CatEntitiesCompanion(
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      description: description ?? this.description,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      lifeSpan: lifeSpan ?? this.lifeSpan,
      wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (temperament.present) {
      map['temperament'] = Variable<String>(temperament.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (lifeSpan.present) {
      map['life_span'] = Variable<String>(lifeSpan.value);
    }
    if (wikipediaUrl.present) {
      map['wikipedia_url'] = Variable<String>(wikipediaUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatEntitiesCompanion(')
          ..write('imageUrl: $imageUrl, ')
          ..write('breed: $breed, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin, ')
          ..write('lifeSpan: $lifeSpan, ')
          ..write('wikipediaUrl: $wikipediaUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LikedCatsTable extends LikedCats
    with TableInfo<$LikedCatsTable, LikedCat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikedCatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cat_entities (image_url)'));
  static const VerificationMeta _likedDateMeta =
      const VerificationMeta('likedDate');
  @override
  late final GeneratedColumn<DateTime> likedDate = GeneratedColumn<DateTime>(
      'liked_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [imageUrl, likedDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liked_cats';
  @override
  VerificationContext validateIntegrity(Insertable<LikedCat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('liked_date')) {
      context.handle(_likedDateMeta,
          likedDate.isAcceptableOrUnknown(data['liked_date']!, _likedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {imageUrl};
  @override
  LikedCat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LikedCat(
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      likedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}liked_date'])!,
    );
  }

  @override
  $LikedCatsTable createAlias(String alias) {
    return $LikedCatsTable(attachedDatabase, alias);
  }
}

class LikedCat extends DataClass implements Insertable<LikedCat> {
  final String imageUrl;
  final DateTime likedDate;
  const LikedCat({required this.imageUrl, required this.likedDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['image_url'] = Variable<String>(imageUrl);
    map['liked_date'] = Variable<DateTime>(likedDate);
    return map;
  }

  LikedCatsCompanion toCompanion(bool nullToAbsent) {
    return LikedCatsCompanion(
      imageUrl: Value(imageUrl),
      likedDate: Value(likedDate),
    );
  }

  factory LikedCat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LikedCat(
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      likedDate: serializer.fromJson<DateTime>(json['likedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'imageUrl': serializer.toJson<String>(imageUrl),
      'likedDate': serializer.toJson<DateTime>(likedDate),
    };
  }

  LikedCat copyWith({String? imageUrl, DateTime? likedDate}) => LikedCat(
        imageUrl: imageUrl ?? this.imageUrl,
        likedDate: likedDate ?? this.likedDate,
      );
  LikedCat copyWithCompanion(LikedCatsCompanion data) {
    return LikedCat(
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      likedDate: data.likedDate.present ? data.likedDate.value : this.likedDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LikedCat(')
          ..write('imageUrl: $imageUrl, ')
          ..write('likedDate: $likedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(imageUrl, likedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikedCat &&
          other.imageUrl == this.imageUrl &&
          other.likedDate == this.likedDate);
}

class LikedCatsCompanion extends UpdateCompanion<LikedCat> {
  final Value<String> imageUrl;
  final Value<DateTime> likedDate;
  final Value<int> rowid;
  const LikedCatsCompanion({
    this.imageUrl = const Value.absent(),
    this.likedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LikedCatsCompanion.insert({
    required String imageUrl,
    this.likedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : imageUrl = Value(imageUrl);
  static Insertable<LikedCat> custom({
    Expression<String>? imageUrl,
    Expression<DateTime>? likedDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (imageUrl != null) 'image_url': imageUrl,
      if (likedDate != null) 'liked_date': likedDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LikedCatsCompanion copyWith(
      {Value<String>? imageUrl,
      Value<DateTime>? likedDate,
      Value<int>? rowid}) {
    return LikedCatsCompanion(
      imageUrl: imageUrl ?? this.imageUrl,
      likedDate: likedDate ?? this.likedDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (likedDate.present) {
      map['liked_date'] = Variable<DateTime>(likedDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatsCompanion(')
          ..write('imageUrl: $imageUrl, ')
          ..write('likedDate: $likedDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StatsTable extends Stats with TableInfo<$StatsTable, Stat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _totalSwipesMeta =
      const VerificationMeta('totalSwipes');
  @override
  late final GeneratedColumn<int> totalSwipes = GeneratedColumn<int>(
      'total_swipes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [totalSwipes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats';
  @override
  VerificationContext validateIntegrity(Insertable<Stat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('total_swipes')) {
      context.handle(
          _totalSwipesMeta,
          totalSwipes.isAcceptableOrUnknown(
              data['total_swipes']!, _totalSwipesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {totalSwipes};
  @override
  Stat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Stat(
      totalSwipes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_swipes'])!,
    );
  }

  @override
  $StatsTable createAlias(String alias) {
    return $StatsTable(attachedDatabase, alias);
  }
}

class Stat extends DataClass implements Insertable<Stat> {
  final int totalSwipes;
  const Stat({required this.totalSwipes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['total_swipes'] = Variable<int>(totalSwipes);
    return map;
  }

  StatsCompanion toCompanion(bool nullToAbsent) {
    return StatsCompanion(
      totalSwipes: Value(totalSwipes),
    );
  }

  factory Stat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stat(
      totalSwipes: serializer.fromJson<int>(json['totalSwipes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'totalSwipes': serializer.toJson<int>(totalSwipes),
    };
  }

  Stat copyWith({int? totalSwipes}) => Stat(
        totalSwipes: totalSwipes ?? this.totalSwipes,
      );
  Stat copyWithCompanion(StatsCompanion data) {
    return Stat(
      totalSwipes:
          data.totalSwipes.present ? data.totalSwipes.value : this.totalSwipes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Stat(')
          ..write('totalSwipes: $totalSwipes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => totalSwipes.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Stat && other.totalSwipes == this.totalSwipes);
}

class StatsCompanion extends UpdateCompanion<Stat> {
  final Value<int> totalSwipes;
  const StatsCompanion({
    this.totalSwipes = const Value.absent(),
  });
  StatsCompanion.insert({
    this.totalSwipes = const Value.absent(),
  });
  static Insertable<Stat> custom({
    Expression<int>? totalSwipes,
  }) {
    return RawValuesInsertable({
      if (totalSwipes != null) 'total_swipes': totalSwipes,
    });
  }

  StatsCompanion copyWith({Value<int>? totalSwipes}) {
    return StatsCompanion(
      totalSwipes: totalSwipes ?? this.totalSwipes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (totalSwipes.present) {
      map['total_swipes'] = Variable<int>(totalSwipes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsCompanion(')
          ..write('totalSwipes: $totalSwipes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CatEntitiesTable catEntities = $CatEntitiesTable(this);
  late final $LikedCatsTable likedCats = $LikedCatsTable(this);
  late final $StatsTable stats = $StatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [catEntities, likedCats, stats];
}

typedef $$CatEntitiesTableCreateCompanionBuilder = CatEntitiesCompanion
    Function({
  required String imageUrl,
  required String breed,
  required String description,
  required String temperament,
  required String origin,
  required String lifeSpan,
  required String wikipediaUrl,
  Value<int> rowid,
});
typedef $$CatEntitiesTableUpdateCompanionBuilder = CatEntitiesCompanion
    Function({
  Value<String> imageUrl,
  Value<String> breed,
  Value<String> description,
  Value<String> temperament,
  Value<String> origin,
  Value<String> lifeSpan,
  Value<String> wikipediaUrl,
  Value<int> rowid,
});

final class $$CatEntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $CatEntitiesTable, CatEntity> {
  $$CatEntitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LikedCatsTable, List<LikedCat>>
      _likedCatsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.likedCats,
              aliasName: $_aliasNameGenerator(
                  db.catEntities.imageUrl, db.likedCats.imageUrl));

  $$LikedCatsTableProcessedTableManager get likedCatsRefs {
    final manager = $$LikedCatsTableTableManager($_db, $_db.likedCats).filter(
        (f) =>
            f.imageUrl.imageUrl.sqlEquals($_itemColumn<String>('image_url')!));

    final cache = $_typedResult.readTableOrNull(_likedCatsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CatEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CatEntitiesTable> {
  $$CatEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get breed => $composableBuilder(
      column: $table.breed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get temperament => $composableBuilder(
      column: $table.temperament, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lifeSpan => $composableBuilder(
      column: $table.lifeSpan, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wikipediaUrl => $composableBuilder(
      column: $table.wikipediaUrl, builder: (column) => ColumnFilters(column));

  Expression<bool> likedCatsRefs(
      Expression<bool> Function($$LikedCatsTableFilterComposer f) f) {
    final $$LikedCatsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imageUrl,
        referencedTable: $db.likedCats,
        getReferencedColumn: (t) => t.imageUrl,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LikedCatsTableFilterComposer(
              $db: $db,
              $table: $db.likedCats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CatEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CatEntitiesTable> {
  $$CatEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get breed => $composableBuilder(
      column: $table.breed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get temperament => $composableBuilder(
      column: $table.temperament, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lifeSpan => $composableBuilder(
      column: $table.lifeSpan, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wikipediaUrl => $composableBuilder(
      column: $table.wikipediaUrl,
      builder: (column) => ColumnOrderings(column));
}

class $$CatEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatEntitiesTable> {
  $$CatEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get temperament => $composableBuilder(
      column: $table.temperament, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get lifeSpan =>
      $composableBuilder(column: $table.lifeSpan, builder: (column) => column);

  GeneratedColumn<String> get wikipediaUrl => $composableBuilder(
      column: $table.wikipediaUrl, builder: (column) => column);

  Expression<T> likedCatsRefs<T extends Object>(
      Expression<T> Function($$LikedCatsTableAnnotationComposer a) f) {
    final $$LikedCatsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imageUrl,
        referencedTable: $db.likedCats,
        getReferencedColumn: (t) => t.imageUrl,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LikedCatsTableAnnotationComposer(
              $db: $db,
              $table: $db.likedCats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CatEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CatEntitiesTable,
    CatEntity,
    $$CatEntitiesTableFilterComposer,
    $$CatEntitiesTableOrderingComposer,
    $$CatEntitiesTableAnnotationComposer,
    $$CatEntitiesTableCreateCompanionBuilder,
    $$CatEntitiesTableUpdateCompanionBuilder,
    (CatEntity, $$CatEntitiesTableReferences),
    CatEntity,
    PrefetchHooks Function({bool likedCatsRefs})> {
  $$CatEntitiesTableTableManager(_$AppDatabase db, $CatEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> imageUrl = const Value.absent(),
            Value<String> breed = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> temperament = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<String> lifeSpan = const Value.absent(),
            Value<String> wikipediaUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CatEntitiesCompanion(
            imageUrl: imageUrl,
            breed: breed,
            description: description,
            temperament: temperament,
            origin: origin,
            lifeSpan: lifeSpan,
            wikipediaUrl: wikipediaUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String imageUrl,
            required String breed,
            required String description,
            required String temperament,
            required String origin,
            required String lifeSpan,
            required String wikipediaUrl,
            Value<int> rowid = const Value.absent(),
          }) =>
              CatEntitiesCompanion.insert(
            imageUrl: imageUrl,
            breed: breed,
            description: description,
            temperament: temperament,
            origin: origin,
            lifeSpan: lifeSpan,
            wikipediaUrl: wikipediaUrl,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CatEntitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({likedCatsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (likedCatsRefs) db.likedCats],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (likedCatsRefs)
                    await $_getPrefetchedData<CatEntity, $CatEntitiesTable,
                            LikedCat>(
                        currentTable: table,
                        referencedTable: $$CatEntitiesTableReferences
                            ._likedCatsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CatEntitiesTableReferences(db, table, p0)
                                .likedCatsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.imageUrl == item.imageUrl),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CatEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CatEntitiesTable,
    CatEntity,
    $$CatEntitiesTableFilterComposer,
    $$CatEntitiesTableOrderingComposer,
    $$CatEntitiesTableAnnotationComposer,
    $$CatEntitiesTableCreateCompanionBuilder,
    $$CatEntitiesTableUpdateCompanionBuilder,
    (CatEntity, $$CatEntitiesTableReferences),
    CatEntity,
    PrefetchHooks Function({bool likedCatsRefs})>;
typedef $$LikedCatsTableCreateCompanionBuilder = LikedCatsCompanion Function({
  required String imageUrl,
  Value<DateTime> likedDate,
  Value<int> rowid,
});
typedef $$LikedCatsTableUpdateCompanionBuilder = LikedCatsCompanion Function({
  Value<String> imageUrl,
  Value<DateTime> likedDate,
  Value<int> rowid,
});

final class $$LikedCatsTableReferences
    extends BaseReferences<_$AppDatabase, $LikedCatsTable, LikedCat> {
  $$LikedCatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CatEntitiesTable _imageUrlTable(_$AppDatabase db) =>
      db.catEntities.createAlias(
          $_aliasNameGenerator(db.likedCats.imageUrl, db.catEntities.imageUrl));

  $$CatEntitiesTableProcessedTableManager get imageUrl {
    final $_column = $_itemColumn<String>('image_url')!;

    final manager = $$CatEntitiesTableTableManager($_db, $_db.catEntities)
        .filter((f) => f.imageUrl.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_imageUrlTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LikedCatsTableFilterComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get likedDate => $composableBuilder(
      column: $table.likedDate, builder: (column) => ColumnFilters(column));

  $$CatEntitiesTableFilterComposer get imageUrl {
    final $$CatEntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imageUrl,
        referencedTable: $db.catEntities,
        getReferencedColumn: (t) => t.imageUrl,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatEntitiesTableFilterComposer(
              $db: $db,
              $table: $db.catEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LikedCatsTableOrderingComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get likedDate => $composableBuilder(
      column: $table.likedDate, builder: (column) => ColumnOrderings(column));

  $$CatEntitiesTableOrderingComposer get imageUrl {
    final $$CatEntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imageUrl,
        referencedTable: $db.catEntities,
        getReferencedColumn: (t) => t.imageUrl,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatEntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.catEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LikedCatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get likedDate =>
      $composableBuilder(column: $table.likedDate, builder: (column) => column);

  $$CatEntitiesTableAnnotationComposer get imageUrl {
    final $$CatEntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.imageUrl,
        referencedTable: $db.catEntities,
        getReferencedColumn: (t) => t.imageUrl,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatEntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.catEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LikedCatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LikedCatsTable,
    LikedCat,
    $$LikedCatsTableFilterComposer,
    $$LikedCatsTableOrderingComposer,
    $$LikedCatsTableAnnotationComposer,
    $$LikedCatsTableCreateCompanionBuilder,
    $$LikedCatsTableUpdateCompanionBuilder,
    (LikedCat, $$LikedCatsTableReferences),
    LikedCat,
    PrefetchHooks Function({bool imageUrl})> {
  $$LikedCatsTableTableManager(_$AppDatabase db, $LikedCatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LikedCatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LikedCatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LikedCatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> imageUrl = const Value.absent(),
            Value<DateTime> likedDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LikedCatsCompanion(
            imageUrl: imageUrl,
            likedDate: likedDate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String imageUrl,
            Value<DateTime> likedDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LikedCatsCompanion.insert(
            imageUrl: imageUrl,
            likedDate: likedDate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LikedCatsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({imageUrl = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (imageUrl) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.imageUrl,
                    referencedTable:
                        $$LikedCatsTableReferences._imageUrlTable(db),
                    referencedColumn:
                        $$LikedCatsTableReferences._imageUrlTable(db).imageUrl,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LikedCatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LikedCatsTable,
    LikedCat,
    $$LikedCatsTableFilterComposer,
    $$LikedCatsTableOrderingComposer,
    $$LikedCatsTableAnnotationComposer,
    $$LikedCatsTableCreateCompanionBuilder,
    $$LikedCatsTableUpdateCompanionBuilder,
    (LikedCat, $$LikedCatsTableReferences),
    LikedCat,
    PrefetchHooks Function({bool imageUrl})>;
typedef $$StatsTableCreateCompanionBuilder = StatsCompanion Function({
  Value<int> totalSwipes,
});
typedef $$StatsTableUpdateCompanionBuilder = StatsCompanion Function({
  Value<int> totalSwipes,
});

class $$StatsTableFilterComposer extends Composer<_$AppDatabase, $StatsTable> {
  $$StatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get totalSwipes => $composableBuilder(
      column: $table.totalSwipes, builder: (column) => ColumnFilters(column));
}

class $$StatsTableOrderingComposer
    extends Composer<_$AppDatabase, $StatsTable> {
  $$StatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get totalSwipes => $composableBuilder(
      column: $table.totalSwipes, builder: (column) => ColumnOrderings(column));
}

class $$StatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatsTable> {
  $$StatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get totalSwipes => $composableBuilder(
      column: $table.totalSwipes, builder: (column) => column);
}

class $$StatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StatsTable,
    Stat,
    $$StatsTableFilterComposer,
    $$StatsTableOrderingComposer,
    $$StatsTableAnnotationComposer,
    $$StatsTableCreateCompanionBuilder,
    $$StatsTableUpdateCompanionBuilder,
    (Stat, BaseReferences<_$AppDatabase, $StatsTable, Stat>),
    Stat,
    PrefetchHooks Function()> {
  $$StatsTableTableManager(_$AppDatabase db, $StatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> totalSwipes = const Value.absent(),
          }) =>
              StatsCompanion(
            totalSwipes: totalSwipes,
          ),
          createCompanionCallback: ({
            Value<int> totalSwipes = const Value.absent(),
          }) =>
              StatsCompanion.insert(
            totalSwipes: totalSwipes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StatsTable,
    Stat,
    $$StatsTableFilterComposer,
    $$StatsTableOrderingComposer,
    $$StatsTableAnnotationComposer,
    $$StatsTableCreateCompanionBuilder,
    $$StatsTableUpdateCompanionBuilder,
    (Stat, BaseReferences<_$AppDatabase, $StatsTable, Stat>),
    Stat,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CatEntitiesTableTableManager get catEntities =>
      $$CatEntitiesTableTableManager(_db, _db.catEntities);
  $$LikedCatsTableTableManager get likedCats =>
      $$LikedCatsTableTableManager(_db, _db.likedCats);
  $$StatsTableTableManager get stats =>
      $$StatsTableTableManager(_db, _db.stats);
}
