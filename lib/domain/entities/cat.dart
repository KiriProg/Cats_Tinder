class Cat {
  final String imageUrl;
  final String breed;
  final String description;
  final String temperament;
  final String origin;
  final String lifeSpan;
  final String wikipediaUrl;
  final DateTime? likedDate;

  Cat({
    required this.imageUrl,
    required this.breed,
    required this.description,
    required this.temperament,
    required this.origin,
    required this.lifeSpan,
    required this.wikipediaUrl,
    this.likedDate,
  });

  Cat copyWith({
    String? imageUrl,
    String? breed,
    String? description,
    String? temperament,
    String? origin,
    String? lifeSpan,
    String? wikipediaUrl,
    DateTime? likedDate,
  }) {
    return Cat(
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      description: description ?? this.description,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      lifeSpan: lifeSpan ?? this.lifeSpan,
      wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
      likedDate: likedDate ?? this.likedDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => imageUrl.hashCode;
}
