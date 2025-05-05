import 'package:cats_tinder/data/local/database.dart';
import 'package:cats_tinder/data/datasources/local_data_source.dart';
import 'package:cats_tinder/presentation/screens/profile/profile_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/cat_remote_data_source.dart';
import 'data/repositories/cat_repository_impl.dart';
import 'domain/repositories/cat_repository.dart';
import 'domain/usecases/get_cats.dart';
import 'presentation/cubits/cats_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  getIt.registerSingleton<LocalDataSource>(
    LocalDataSourceImpl(getIt<AppDatabase>()),
  );

  getIt.registerSingleton<http.Client>(http.Client());
  getIt.registerSingleton<Connectivity>(Connectivity());

  getIt.registerSingleton<CatRemoteDataSource>(
    CatRemoteDataSource(getIt<http.Client>()),
  );

  getIt.registerSingleton<CatRepository>(
    CatRepositoryImpl(
      remoteDataSource: getIt<CatRemoteDataSource>(),
      localDataSource: getIt<LocalDataSource>(),
      connectivity: getIt<Connectivity>(),
    ),
  );

  getIt.registerSingleton<GetCats>(GetCats(getIt<CatRepository>()));

  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);

  getIt.registerFactory(() => const ProfileScreen());

  getIt.registerFactory<CatsCubit>(
    () => CatsCubit(
      sharedPrefs: getIt<SharedPreferences>(),
      getCats: getIt<GetCats>(),
      localDataSource: getIt<LocalDataSource>(),
      connectivity: getIt<Connectivity>(),
    ),
  );
}
