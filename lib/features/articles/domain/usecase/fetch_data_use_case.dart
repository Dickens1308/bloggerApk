import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/article_entity.dart';
import '../repository/article_repository.dart';

class FetchDataUseCase implements UseCase<List<ArticleEntity>, ArticleParam> {
  final ArticleRepository articleRepo;

  FetchDataUseCase(this.articleRepo);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(ArticleParam params) async {
    return await articleRepo.fetchData();
  }
}
