class Cat {
  final String imageUrl;
  final String breed;
  final String description;
  final String temperament;
  final String origin;
  final String lifeSpan;
  final String wikipediaUrl;
  final DateTime likedDate;

  Cat({
    required this.imageUrl,
    required this.breed,
    required this.description,
    required this.temperament,
    required this.origin,
    required this.lifeSpan,
    required this.wikipediaUrl,
    DateTime? likedDate,
  }) : likedDate = likedDate ?? DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => imageUrl.hashCode;
}
