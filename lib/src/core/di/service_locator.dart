import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:wigilabs_test/app_exports.dart';
import 'package:wigilabs_test/src/core/config/dio_http_client.dart';
import 'package:wigilabs_test/src/core/config/http_client_base.dart';
import 'package:wigilabs_test/src/data/database/app_database.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Database
  final database = await _initDatabase();
  getIt.registerSingleton<AppDatabase>(database);

  // HTTP Client
  final dio = Dio();
  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<HttpClient>(
    DioHttpClientImpl(dio: dio),
  );

  // Datasources
  getIt.registerSingleton<CountriesRemoteDatasource>(
    CountriesRemoteDatasourceImpl(
      httpClient: getIt<HttpClient>(),
    ),
  );

  getIt.registerSingleton<WishlistLocalDatasource>(
    WishlistLocalDatasourceImpl(
      database: getIt<AppDatabase>(),
    ),
  );

  // Repositories
  getIt.registerSingleton<CountriesRepository>(
    CountriesRepositoryImpl(
      remoteDatasource: getIt<CountriesRemoteDatasource>(),
    ),
  );

  getIt.registerSingleton<WishlistRepository>(
    WishlistRepositoryImpl(
      localDatasource: getIt<WishlistLocalDatasource>(),
    ),
  );

  // Use Cases
  getIt.registerSingleton<GetEuropeanCountriesUsecase>(
    GetEuropeanCountriesUsecase(repository: getIt<CountriesRepository>()),
  );

  getIt.registerSingleton<GetCountryByNameUsecase>(
    GetCountryByNameUsecase(repository: getIt<CountriesRepository>()),
  );

  getIt.registerSingleton<AddToWishlistUsecase>(
    AddToWishlistUsecase(repository: getIt<WishlistRepository>()),
  );

  getIt.registerSingleton<RemoveFromWishlistUsecase>(
    RemoveFromWishlistUsecase(repository: getIt<WishlistRepository>()),
  );

  getIt.registerSingleton<GetAllWishlistItemsUsecase>(
    GetAllWishlistItemsUsecase(repository: getIt<WishlistRepository>()),
  );

  getIt.registerSingleton<IsCountryInWishlistUsecase>(
    IsCountryInWishlistUsecase(repository: getIt<WishlistRepository>()),
  );

  getIt.registerSingleton<ClearWishlistUsecase>(
    ClearWishlistUsecase(repository: getIt<WishlistRepository>()),
  );

  // BLoCs
  getIt.registerSingleton<CountriesBloc>(
    CountriesBloc(
      getEuropeanCountriesUsecase: getIt<GetEuropeanCountriesUsecase>(),
    ),
  );

  getIt.registerSingleton<CountryDetailsBloc>(
    CountryDetailsBloc(
      getCountryByNameUsecase: getIt<GetCountryByNameUsecase>(),
    ),
  );

  getIt.registerSingleton<WishlistBloc>(
    WishlistBloc(
      addToWishlistUsecase: getIt<AddToWishlistUsecase>(),
      removeFromWishlistUsecase: getIt<RemoveFromWishlistUsecase>(),
      getAllWishlistItemsUsecase: getIt<GetAllWishlistItemsUsecase>(),
      isCountryInWishlistUsecase: getIt<IsCountryInWishlistUsecase>(),
      clearWishlistUsecase: getIt<ClearWishlistUsecase>(),
    ),
  );
}

Future<AppDatabase> _initDatabase() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'wigilabs_app.db'));

  return AppDatabase(
    NativeDatabase(file),
  );
}
