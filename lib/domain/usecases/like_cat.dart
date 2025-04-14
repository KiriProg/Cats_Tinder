import 'package:cats_tinder/domain/entities/cat.dart';

class LikeCat {
  void execute(Cat cat, List<Cat> currentLikedCats) {
    if (!currentLikedCats.contains(cat)) {
      currentLikedCats.add(cat);
    }
  }
}
