import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

@DriftDatabase(tables: [CatEntities, LikedCats, Stats])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> deleteAllData() async {
    await delete(catEntities).go();
    await delete(likedCats).go();
    await delete(stats).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cats_db.sqlite'));
    return NativeDatabase(file);
  });
}

@DataClassName('CatEntity')
class CatEntities extends Table {
  TextColumn get imageUrl => text()();
  TextColumn get breed => text()();
  TextColumn get description => text()();
  TextColumn get temperament => text()();
  TextColumn get origin => text()();
  TextColumn get lifeSpan => text()();
  TextColumn get wikipediaUrl => text()();

  @override
  Set<Column> get primaryKey => {imageUrl};
}

class LikedCats extends Table {
  TextColumn get imageUrl => text().references(CatEntities, #imageUrl)();
  DateTimeColumn get likedDate => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {imageUrl};
}

class Stats extends Table {
  IntColumn get totalSwipes => integer()();
  @override
  Set<Column> get primaryKey => {totalSwipes};
}
