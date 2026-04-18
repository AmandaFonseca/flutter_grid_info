import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_grid_info/features/feature_home/data/datasources/home_local_data_source/home_local_data_source.dart';
import 'package:flutter_grid_info/features/feature_home/data/datasources/home_local_data_source/home_local_data_source_impl.dart';
import 'package:flutter_grid_info/features/feature_home/data/repositories/home_repository_impl.dart';
import 'package:flutter_grid_info/features/feature_home/domain/repositories/home_repository.dart';
import 'package:flutter_grid_info/features/feature_home/domain/usecases/home_usecase.dart';
import 'package:flutter_grid_info/features/features_login/data/datasources/login_local_data_source/login_local_data_source.dart';
import 'package:flutter_grid_info/features/features_login/data/datasources/login_local_data_source/login_local_data_source_impl.dart';
import 'package:flutter_grid_info/features/features_login/data/repositories/login_repository_impl.dart';
import 'package:flutter_grid_info/features/features_login/domain/repositories/login_repository.dart';
import 'package:flutter_grid_info/features/features_login/domain/usecases/login_usecases/login_usecase.dart';
import 'package:flutter_grid_info/features/features_login/presentation/_stores/login_store.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpContainer() async {
  await dotenv.load(fileName: ".env");

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  //features
  login();
  home();
}

void login() {
  getIt.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(repository: getIt()),
  );

  getIt.registerFactory(() => LoginStore(getIt()));
}

void home() {
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(repository: getIt()),
  );

  getIt.registerFactory(() => HomeStore(getIt()));
}
