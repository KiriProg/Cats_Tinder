import 'dart:async';

import 'package:cats_tinder/data/datasources/local_data_source.dart';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/domain/usecases/get_cats.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cats_state.dart';

class CatsCubit extends Cubit<CatsState> {
  final GetCats _getCats;
  final SharedPreferences sharedPrefs;
  final LocalDataSource _localDataSource;
  final List<Cat> _allLoadedCats = [];
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  CatsCubit({
    required this.sharedPrefs,
    required GetCats getCats,
    required LocalDataSource localDataSource,
    required Connectivity connectivity,
  })  : _getCats = getCats,
        _localDataSource = localDataSource,
        _connectivity = connectivity,
        super(
            CatsState.initial(sharedPrefs.getString('breed') ?? 'Your Breed')) {
    _loadInitialData();
    _initNetworkListener();
  }

  Future<void> _loadInitialData() async {
    final likedCats = await _localDataSource.getLikedCats();
    final totalSwipes = await _localDataSource.getTotalSwipes();
    emit(state.copyWith(
      likedCats: likedCats,
      likesCount: likedCats.length,
      totalSwipes: totalSwipes,
    ));
    await loadCats();
  }

  void incrementSwipes() {
    _localDataSource.incrementTotalSwipes();
    emit(state.copyWith(
      totalSwipes: state.totalSwipes + 1,
    ));
  }

  Future<void> loadCats({bool isRetry = false}) async {
    await _updateNetworkStatus();

    if (state.status == CatsStatus.loading && !isRetry) return;

    emit(state.copyWith(
      status: CatsStatus.loading,
      errorMessage: isRetry ? null : state.errorMessage,
    ));

    try {
      final newCats = await _getCats.execute();
      _allLoadedCats.addAll(newCats);

      emit(state.copyWith(
        status: CatsStatus.success,
        cats: _allLoadedCats,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CatsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void swipeCat(CardSwiperDirection direction, int index) {
    if (state.cats.isEmpty || index >= state.cats.length) return;

    final cat = state.cats[index];
    incrementSwipes();

    if (direction == CardSwiperDirection.right) {
      likeCat(cat);
    }
    if (index == state.cats.length - 1) {
      state.cats.clear();
      loadCats();
    }
  }

  Future<void> likeCat(Cat cat) async {
    final catWithDate = cat.copyWith(likedDate: DateTime.now());
    try {
      await _localDataSource.likeCat(catWithDate);
      emit(state.copyWith(
        likedCats: [...state.likedCats, catWithDate],
        likesCount: state.likesCount + 1,
      ));
    } catch (e) {
      if (kDebugMode) {
        print("CatCubit.likeCat: $e");
      }
    }
  }

  Future<void> removeLikedCat(Cat cat) async {
    try {
      await _localDataSource.dislikeCat(cat.imageUrl);

      emit(state.copyWith(
        likedCats: state.likedCats.where((c) => c != cat).toList(),
        likesCount: state.likesCount - 1,
      ));
    } catch (e) {
      if (kDebugMode) print('Error removing liked cat: $e');
    }
  }

  void updateBreed(String newBreed) async {
    if (newBreed.trim().isEmpty) return;

    try {
      await sharedPrefs.setString('breed', newBreed.trim());
      emit(state.copyWith(favoriteBreed: newBreed.trim()));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to save breed'));
    }
  }

  void _initNetworkListener() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      final newStatus = !result.contains(ConnectivityResult.none)
          ? NetworkStatus.online
          : NetworkStatus.offline;

      if (newStatus != state.networkStatus) {
        emit(state.copyWith(
            lastNetworkStatus: state.networkStatus, networkStatus: newStatus));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }

  Future<void> _updateNetworkStatus() async {
    final result = await _connectivity.checkConnectivity();
    final isOnline = !result.contains(ConnectivityResult.none);
    emit(state.copyWith(
        lastNetworkStatus: state.networkStatus,
        networkStatus:
            isOnline ? NetworkStatus.online : NetworkStatus.offline));
  }
}
