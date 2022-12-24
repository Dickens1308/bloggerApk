import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entity/article_entity.dart';
import '../../domain/repository/article_repository.dart';
import '../datasource/article_local_data_source.dart';
import '../datasource/article_remote_data_source.dart';
import '../models/article_model.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;
  final ArticleLocalDataSource articleLocalDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.articleRemoteDataSource,
    required this.networkInfo,
    required this.articleLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ArticleModel>>> fetchData() async =>
      await _fetchData(null);

  @override
  Future<Either<Failure, List<ArticleModel>>> fetchMoreData(
          int? pageNum) async =>
      await _fetchData(pageNum);

  Future<Either<Failure, List<ArticleModel>>> _fetchData(int? pageNum) async {
    try {
      bool connection = await networkInfo.isConnected;
      List<ArticleModel> list = [];

      if (connection) {
        list = pageNum == null
            ? await articleRemoteDataSource.fetchData()
            : await articleRemoteDataSource.fetchMoreData(pageNum);
      } else {
        list = await articleLocalDataSource.fetchData();
      }

      return Right(list);
    } catch (e) {
      log(e.toString());
      return const Left(ServerFailure(message: "hello"));
    }
  }

  @override
  Future<Either<Failure, int?>> bookmarkArticle(
      ArticleEntity articleEntity) async {
    try {
      int? update = await articleLocalDataSource
          .bookmarkArticle(articleEntity as ArticleModel);

      return Right(update);
    } catch (e) {
      log("error from repo is $e");
      return const Left(CacheFailure(message: "Failed to update bookmark"));
    }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> fetchBookmarkPost() async {
    try {
      List<ArticleModel> list = [];
      list = await articleLocalDataSource.fetchBookmarkPost();
      return Right(list);
    } catch (e) {
      log("error from repo is $e");
      return const Left(CacheFailure(message: "Failed to fetch bookmark"));
    }
  }
}
