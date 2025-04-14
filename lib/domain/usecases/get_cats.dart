import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/domain/repositories/cat_repository.dart';

class GetCats {
  final CatRepository repository;

  GetCats(this.repository);

  Future<List<Cat>> execute() async {
    return await repository.fetchCats();
  }
}
