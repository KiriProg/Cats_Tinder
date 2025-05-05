import 'package:cats_tinder/data/local/database.dart';
import 'package:drift/drift.dart';
import 'package:cats_tinder/domain/entities/cat.dart' as domain;

abstract class LocalDataSource {
  Future<void> saveCats(List<domain.Cat> cats);
  Future<List<domain.Cat>> getCachedCats();
  Future<void> likeCat(domain.Cat cat);
  Future<void> dislikeCat(String imageUrl);
  Future<List<domain.Cat>> getLikedCats();
  Future<void> clearCats();
  Future<int> getTotalSwipes();
  Future<void> incrementTotalSwipes();
}

class LocalDataSourceImpl implements LocalDataSource {
  final AppDatabase _db;

  LocalDataSourceImpl(this._db);

  @override
  Future<void> saveCats(List<domain.Cat> cats) async {
    await _db.batch((batch) {
      batch.insertAll(
        _db.catEntities,
        cats.map((cat) => CatEntitiesCompanion.insert(
              imageUrl: cat.imageUrl,
              breed: cat.breed,
              description: cat.description,
              temperament: cat.temperament,
              origin: cat.origin,
              lifeSpan: cat.lifeSpan,
              wikipediaUrl: cat.wikipediaUrl,
            )),
        onConflict: DoNothing(),
      );
    });
  }

  @override
  Future<void> clearCats() async {
    await _db.delete(_db.catEntities).go();
  }

  @override
  Future<List<domain.Cat>> getCachedCats() async {
    final results = await _db.select(_db.catEntities).get();
    return results
        .map((row) => domain.Cat(
              imageUrl: row.imageUrl,
              breed: row.breed,
              description: row.description,
              temperament: row.temperament,
              origin: row.origin,
              lifeSpan: row.lifeSpan,
              wikipediaUrl: row.wikipediaUrl,
            ))
        .toList();
  }

  @override
  Future<void> likeCat(domain.Cat cat) async {
    await _db.into(_db.likedCats).insert(
          LikedCatsCompanion.insert(
            imageUrl: cat.imageUrl,
            likedDate: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> dislikeCat(String imageUrl) async {
    await (_db.delete(_db.likedCats)
          ..where((tbl) => tbl.imageUrl.equals(imageUrl)))
        .go();
  }

  @override
  Future<List<domain.Cat>> getLikedCats() async {
    final query = _db.select(_db.catEntities).join([
      innerJoin(_db.likedCats,
          _db.likedCats.imageUrl.equalsExp(_db.catEntities.imageUrl)),
    ]);

    return await query.map((row) {
      final catData = row.readTable(_db.catEntities);
      return domain.Cat(
        imageUrl: catData.imageUrl,
        breed: catData.breed,
        description: catData.description,
        temperament: catData.temperament,
        origin: catData.origin,
        lifeSpan: catData.lifeSpan,
        wikipediaUrl: catData.wikipediaUrl,
        likedDate: row.readTable(_db.likedCats).likedDate,
      );
    }).get();
  }

  @override
  Future<int> getTotalSwipes() async {
    final result = await _db.select(_db.stats).getSingleOrNull();
    return result?.totalSwipes ?? 0;
  }

  @override
  Future<void> incrementTotalSwipes() async {
    final current = await (_db.select(_db.stats)).getSingleOrNull();
    if (current != null) {
      await _db
          .update(_db.stats)
          .write(StatsCompanion(totalSwipes: Value(current.totalSwipes + 1)));
    } else {
      await _db
          .into(_db.stats)
          .insert(const StatsCompanion(totalSwipes: Value(1)));
    }
  }
}
