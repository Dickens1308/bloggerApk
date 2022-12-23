import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/article_entity.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleEntity>>> fetchData();

  Future<Either<Failure, List<ArticleEntity>>> fetchMoreData(int? pageNum);

  Future<Either<Failure, int?>> bookmarkArticle(ArticleEntity articleEntity);

  Future<Either<Failure, List<ArticleEntity>>> fetchBookmarkPost();
}
