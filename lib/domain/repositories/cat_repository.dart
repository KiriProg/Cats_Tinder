import 'package:cats_tinder/domain/entities/cat.dart';

abstract class CatRepository {
  Future<List<Cat>> fetchCats();
}
