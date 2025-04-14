import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/domain/usecases/get_cats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cats_state.dart';

class CatsCubit extends Cubit<CatsState> {
  final GetCats _getCats;
  final List<Cat> _allLoadedCats = [];
  final SharedPreferences sharedPrefs;

  CatsCubit(this.sharedPrefs, this._getCats)
      : super(
            CatsState.initial(sharedPrefs.getString('breed') ?? 'Your Breed'));

  void updateBreed(String newBreed) async {
    if (newBreed.trim().isEmpty) return;

    try {
      await sharedPrefs.setString('breed', newBreed.trim());
      emit(state.copyWith(favoriteBreed: newBreed.trim()));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to save breed'));
    }
  }

  void incrementSwipes() {
    emit(state.copyWith(
      totalSwipes: state.totalSwipes + 1,
    ));
  }

  Future<void> loadCats({bool isRetry = false}) async {
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
      rethrow;
    }
  }

  void swipeCat(CardSwiperDirection direction, int index) {
    if (state.cats.isEmpty || index >= state.cats.length) return;

    final cat = state.cats[index];

    emit(state.copyWith(
      totalSwipes: state.totalSwipes + 1,
    ));

    if (direction == CardSwiperDirection.right) {
      likeCat(cat);
    }

    if (index == state.cats.length - 1) {
      state.cats.clear();
      loadCats();
    }
  }

  void likeCat(Cat cat) {
    if (state.likedCats.contains(cat)) return;

    emit(state.copyWith(
      likedCats: [...state.likedCats, cat],
      likesCount: state.likesCount + 1,
    ));
  }

  void removeLikedCat(Cat cat) {
    emit(state.copyWith(
      likedCats: state.likedCats.where((c) => c != cat).toList(),
      likesCount: state.likesCount - 1,
    ));
  }
}
