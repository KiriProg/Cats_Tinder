import 'package:cats_tinder/presentation/cubits/cats_cubit.dart';
import 'package:cats_tinder/presentation/cubits/cats_state.dart';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/domain/usecases/get_cats.dart';
import 'package:cats_tinder/data/datasources/local_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_test/flutter_test.dart' as testing;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetCats extends Mock implements GetCats {}

class MockLocalDataSource extends Mock implements LocalDataSource {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  testing.TestWidgetsFlutterBinding.ensureInitialized();

  late CatsCubit catsCubit;
  late MockGetCats mockGetCats;
  late MockLocalDataSource mockLocalDataSource;
  late MockSharedPreferences mockSharedPreferences;
  late MockConnectivity mockConnectivity;

  final testCat = Cat(
    imageUrl: 'https://test.com/cat1.jpg',
    breed: 'Test Breed',
    description: 'Test Description',
    temperament: 'Test Temperament',
    origin: 'Test Origin',
    lifeSpan: '10-15 years',
    wikipediaUrl: 'https://test.com/wiki',
  );

  setUp(() {
    mockGetCats = MockGetCats();
    mockLocalDataSource = MockLocalDataSource();
    mockSharedPreferences = MockSharedPreferences();
    mockConnectivity = MockConnectivity();

    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(() => mockConnectivity.onConnectivityChanged)
        .thenAnswer((_) => Stream.value([ConnectivityResult.wifi]));

    // final getIt = GetIt.instance;
    // getIt.registerSingleton<SharedPreferences>(mockSharedPreferences);
    // getIt.registerSingleton<LocalDataSource>(mockLocalDataSource);
    // getIt.registerSingleton<GetCats>(mockGetCats);

    when(() => mockSharedPreferences.getString('breed'))
        .thenReturn('Initial Breed');
    when(() => mockLocalDataSource.getLikedCats()).thenAnswer((_) async => []);
    when(() => mockLocalDataSource.getTotalSwipes()).thenAnswer((_) async => 0);
    when(() => mockLocalDataSource.incrementTotalSwipes())
        .thenAnswer((_) async => []);

    catsCubit = CatsCubit(
      sharedPrefs: mockSharedPreferences,
      getCats: mockGetCats,
      localDataSource: mockLocalDataSource,
      connectivity: mockConnectivity,
    );
    registerFallbackValue(testCat);
  });

  tearDown(() {
    catsCubit.close();
  });

  group('Like/Dislike Operations', () {
    blocTest<CatsCubit, CatsState>(
      'likeCat - should add cat to liked list and increment counter',
      build: () {
        catsCubit.emit(CatsState(
          cats: [testCat, testCat],
          likedCats: const [],
          likesCount: 0,
          totalSwipes: 0,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ));
        when(() => mockLocalDataSource.likeCat(any<Cat>()))
            .thenAnswer((_) async {});
        return catsCubit;
      },
      act: (cubit) => cubit.likeCat(testCat),
      expect: () => [
        CatsState(
          cats: [testCat, testCat],
          likedCats: [testCat],
          likesCount: 1,
          totalSwipes: 0,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ),
      ],
      verify: (_) {
        verify(() => mockLocalDataSource.likeCat(testCat)).called(1);
      },
    );

    blocTest<CatsCubit, CatsState>(
      'likeCat - should handle error when database fails',
      build: () {
        catsCubit.emit(CatsState(
          cats: [testCat],
          likedCats: const [],
          likesCount: 0,
          totalSwipes: 0,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ));

        when(() => mockLocalDataSource.likeCat(any<Cat>()))
            .thenThrow(Exception('Database error'));
        return catsCubit;
      },
      act: (cubit) => cubit.likeCat(testCat),
      expect: () => [],
    );

    blocTest<CatsCubit, CatsState>(
      'removeLikedCat - should remove cat and decrement counter',
      build: () {
        catsCubit.emit(CatsState(
          cats: const [],
          likedCats: [testCat],
          likesCount: 1,
          totalSwipes: 0,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ));

        when(() => mockLocalDataSource.dislikeCat(any<String>()))
            .thenAnswer((_) async {});
        return catsCubit;
      },
      act: (cubit) => cubit.removeLikedCat(testCat),
      expect: () => [
        const CatsState(
          cats: [],
          likedCats: [],
          likesCount: 0,
          totalSwipes: 0,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ),
      ],
      verify: (_) {
        verify(() => mockLocalDataSource.dislikeCat(testCat.imageUrl))
            .called(1);
      },
    );

    blocTest<CatsCubit, CatsState>(
      'swipe right - should like cat',
      build: () {
        catsCubit.emit(CatsState(
          cats: [testCat, testCat],
          likedCats: const [],
          likesCount: 0,
          totalSwipes: 0,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ));

        when(() => mockLocalDataSource.likeCat(any<Cat>()))
            .thenAnswer((_) async {});
        return catsCubit;
      },
      act: (cubit) => cubit.swipeCat(
        CardSwiperDirection.right,
        0,
      ),
      expect: () => [
        CatsState(
          cats: [testCat, testCat],
          likedCats: const [],
          likesCount: 0,
          totalSwipes: 1,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ),
        CatsState(
          cats: [testCat, testCat],
          likedCats: [testCat],
          likesCount: 1,
          totalSwipes: 1,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ),
      ],
    );

    blocTest<CatsCubit, CatsState>(
      'swipe left - should not like cat',
      build: () {
        catsCubit.emit(CatsState(
          cats: [testCat, testCat, testCat],
          likedCats: const [],
          likesCount: 0,
          totalSwipes: 0,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ));
        return catsCubit;
      },
      act: (cubit) => cubit.swipeCat(
        CardSwiperDirection.left,
        0,
      ),
      expect: () => [
        CatsState(
          cats: [testCat, testCat, testCat],
          likedCats: const [],
          likesCount: 0,
          totalSwipes: 1,
          status: CatsStatus.initial,
          favoriteBreed: 'Initial Breed',
          networkStatus: NetworkStatus.online,
        ),
      ],
      verify: (_) {
        verifyNever(() => mockLocalDataSource.likeCat(any<Cat>()));
      },
    );
  });
}
