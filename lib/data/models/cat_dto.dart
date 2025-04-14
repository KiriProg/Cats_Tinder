import 'package:cats_tinder/domain/entities/cat.dart';

class CatDto {
  final String imageUrl;
  final String breed;
  final String description;
  final String temperament;
  final String origin;
  final String lifeSpan;
  final String wikipediaUrl;

  CatDto({
    required this.imageUrl,
    required this.breed,
    required this.description,
    required this.temperament,
    required this.origin,
    required this.lifeSpan,
    required this.wikipediaUrl,
  });

  factory CatDto.fromJson(Map<String, dynamic> json) {
    final breeds = json['breeds'] as List?;
    final breed = breeds != null && breeds.isNotEmpty ? breeds[0] : {};

    return CatDto(
      imageUrl: json['url'] ?? '',
      breed: breed['name'] ?? 'Unknown',
      description: breed['description'] ?? 'No description',
      temperament: breed['temperament'] ?? 'No data',
      origin: breed['origin'] ?? 'Unknown',
      lifeSpan: breed['life_span'] ?? 'Unknown',
      wikipediaUrl: breed['wikipedia_url'] ?? '',
    );
  }

  Cat toEntity() {
    return Cat(
      imageUrl: imageUrl,
      breed: breed,
      description: description,
      temperament: temperament,
      origin: origin,
      lifeSpan: lifeSpan,
      wikipediaUrl: wikipediaUrl,
    );
  }
}
