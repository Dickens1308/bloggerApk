import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../../../core/platform/network_info.dart';
import '../data/datasource/article_local_data_source.dart';
import '../data/datasource/article_remote_data_source.dart';
import '../data/datasource/auth_user_data_source.dart';
import '../data/repository/article_repository_impl.dart';
import '../data/repository/auth_repository_impl.dart';
import '../domain/repository/article_repository.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/usecase/fetch_bookmark_use_case.dart';
import '../domain/usecase/fetch_data_use_case.dart';
import '../domain/usecase/fetch_more_data_use_case.dart';
import '../domain/usecase/forgot_password_use_case.dart';
import '../domain/usecase/login_user_use_case.dart';
import '../domain/usecase/register_user_use_case.dart';
import '../domain/usecase/update_bookmark_use_case.dart';
import 'providers/article_provider.dart';
import 'providers/auth_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //  Feature
  initArticleFeature();
  initAuthFeature();
  //Core
  initCoreInit();
  // External Dependencies
  initExternalDependency();
}

void initExternalDependency() {
  sl.registerLazySingleton(() => Connectivity());
}

void initCoreInit() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void initAuthFeature() {
  //Bloc
  sl.registerFactory(() => AuthProvider(
      forgotPasswordUseCase: sl(),
      loginUserUseCase: sl(),
      registerUserUseCase: sl()));

  //UseCase
  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));

  //Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
}

void initArticleFeature() {
  // Bloc
  sl.registerFactory(
    () => ArticleProvider(
        fetchDataUseCase: sl(),
        fetchMoreDataUseCase: sl(),
        updateArticleBookmarkUsecase: sl(),
        fetchBookmarkUseCase: sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => FetchDataUseCase(sl()));
  sl.registerLazySingleton(() => FetchMoreDataUseCase(sl()));
  sl.registerLazySingleton(() => UpdateArticleBookmarkUsecase(sl()));
  sl.registerLazySingleton(() => FetchBookmarkUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImpl(articleLocalDataSource: sl()));
  sl.registerLazySingleton<ArticleLocalDataSource>(
      () => ArticleLocalDataSourceImpl());
  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
        articleRemoteDataSource: sl(),
        networkInfo: sl(),
        articleLocalDataSource: sl(),
      ));

  //
}
