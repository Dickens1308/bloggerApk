import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:tasks/features/articles/domain/usecase/fetch_bookmark_use_case.dart';
import 'package:tasks/features/articles/domain/usecase/update_bookmark_use_case.dart';

import '../../../core/platform/network_info.dart';
import '../data/datasource/article_local_data_source.dart';
import '../data/datasource/article_remote_data_source.dart';
import '../data/repository/article_repository_impl.dart';
import '../domain/repository/article_repository.dart';
import '../domain/usecase/fetch_data_use_case.dart';
import '../domain/usecase/fetch_more_data_use_case.dart';
import 'providers/article_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //  Feature - Article
  initArticleFeature();
  //  Feature - Core
  initCoreInit();
  //  Feature - External Dependencies
  initExternalDependency();
}

void initExternalDependency() {
  sl.registerLazySingleton(() => Connectivity());
}

void initCoreInit() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
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
