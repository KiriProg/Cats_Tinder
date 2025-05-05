import 'package:cats_tinder/data/datasources/cat_remote_data_source.dart';
import 'package:cats_tinder/data/datasources/local_data_source.dart';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/domain/repositories/cat_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final Connectivity connectivity;

  CatRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  @override
  Future<List<Cat>> fetchCats() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();

      if (!connectivityResult.contains(ConnectivityResult.none)) {
        final cats = await _fetchFromRemote();
        await localDataSource.saveCats(cats);
        await _precacheAllImages(cats);
        return cats;
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      if (kDebugMode) print('Error in fetchCats: $e');
      rethrow;
    }
  }

  Future<void> _precacheAllImages(List<Cat> cats) async {
    final imageCache = DefaultCacheManager();
    final tasks = cats.map((cat) async {
      try {
        await imageCache.downloadFile(cat.imageUrl);
      } catch (e) {
        if (kDebugMode) print('Failed to cache ${cat.imageUrl}: $e');
      }
    });

    await Future.wait(tasks);
  }

  @override
  Future<void> removeLikedCat(String imageUrl) async {
    await localDataSource.dislikeCat(imageUrl);
  }

  Future<List<Cat>> _fetchFromRemote() async {
    try {
      final images = await remoteDataSource.fetchCatImages();
      final cats = <Cat>[];

      for (var image in images) {
        try {
          final cat = await remoteDataSource.fetchFullCatInfo(image['id']);
          cats.add(cat);
        } catch (e) {
          if (kDebugMode) print('Error loading cat ${image['id']}: $e');
        }
      }

      if (cats.isEmpty) throw Exception('No cats with breed info found');
      return cats;
    } catch (e) {
      if (kDebugMode) print('Critical error in _fetchFromRemote: $e');
      rethrow;
    }
  }
}
