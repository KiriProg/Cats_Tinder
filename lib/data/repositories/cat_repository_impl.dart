import 'package:cats_tinder/data/datasources/cat_remote_data_source.dart';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/domain/repositories/cat_repository.dart';
import 'package:flutter/foundation.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remoteDataSource;

  CatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Cat>> fetchCats() async {
    try {
      final images = await remoteDataSource.fetchCatImages();
      final cats = <Cat>[];

      for (var image in images) {
        try {
          final cat = await remoteDataSource.fetchFullCatInfo(image['id']);
          cats.add(cat);
        } catch (e) {
          if (kDebugMode) {
            print('Error loading cat ${image['id']}: $e');
          }
        }
      }

      if (cats.isEmpty) {
        throw Exception('No cats with breed info found');
      }

      return cats;
    } catch (e) {
      if (kDebugMode) {
        print('Critical error: $e');
      }
      rethrow;
    }
  }
}
