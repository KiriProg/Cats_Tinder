import 'package:equatable/equatable.dart';
import '../../domain/entities/cat.dart';

enum CatsStatus { initial, loading, success, error }

class CatsState extends Equatable {
  final List<Cat> cats;
  final List<Cat> likedCats;
  final int likesCount;
  final int totalSwipes;
  final CatsStatus status;
  final String? errorMessage;
  final String favoriteBreed;

  const CatsState({
    this.cats = const [],
    this.likedCats = const [],
    this.likesCount = 0,
    this.totalSwipes = 0,
    this.status = CatsStatus.initial,
    this.errorMessage,
    required this.favoriteBreed,
  });

  factory CatsState.initial(String initialBreed) => CatsState(
        cats: const [],
        likedCats: const [],
        totalSwipes: 0,
        likesCount: 0,
        status: CatsStatus.initial,
        favoriteBreed: initialBreed,
      );

  CatsState copyWith({
    List<Cat>? cats,
    List<Cat>? likedCats,
    int? totalSwipes,
    int? likesCount,
    CatsStatus? status,
    String? errorMessage,
    String? favoriteBreed,
  }) {
    return CatsState(
      cats: cats ?? this.cats,
      likedCats: likedCats ?? this.likedCats,
      totalSwipes: totalSwipes ?? this.totalSwipes,
      likesCount: likesCount ?? this.likesCount,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      favoriteBreed: favoriteBreed ?? this.favoriteBreed,
    );
  }

  @override
  List<Object?> get props => [
        cats,
        likedCats,
        likesCount,
        totalSwipes,
        status,
        errorMessage,
      ];
}
