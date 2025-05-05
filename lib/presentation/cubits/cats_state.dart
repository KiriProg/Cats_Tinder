import 'package:equatable/equatable.dart';
import '../../domain/entities/cat.dart';

enum CatsStatus { initial, loading, success, error }

enum NetworkStatus { online, offline }

class CatsState extends Equatable {
  final List<Cat> cats;
  final List<Cat> likedCats;
  final int likesCount;
  final int totalSwipes;
  final CatsStatus status;
  final String? errorMessage;
  final String favoriteBreed;
  final NetworkStatus networkStatus;
  final NetworkStatus? lastNetworkStatus;

  const CatsState({
    this.cats = const [],
    this.likedCats = const [],
    this.likesCount = 0,
    this.totalSwipes = 0,
    this.status = CatsStatus.initial,
    this.errorMessage,
    required this.favoriteBreed,
    this.networkStatus = NetworkStatus.online,
    this.lastNetworkStatus,
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
    NetworkStatus? networkStatus,
    NetworkStatus? lastNetworkStatus,
    bool? snackBarShown,
  }) {
    return CatsState(
      cats: cats ?? this.cats,
      likedCats: likedCats ?? this.likedCats,
      totalSwipes: totalSwipes ?? this.totalSwipes,
      likesCount: likesCount ?? this.likesCount,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      favoriteBreed: favoriteBreed ?? this.favoriteBreed,
      networkStatus: networkStatus ?? this.networkStatus,
      lastNetworkStatus: lastNetworkStatus ?? this.lastNetworkStatus,
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
        networkStatus,
        lastNetworkStatus,
      ];
}
