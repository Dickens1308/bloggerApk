import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/article_entity.dart';
import '../repository/article_repository.dart';

class UpdateArticleBookmarkUsecase
    implements UseCase<int?, ArticleBookmarkParam> {
  final ArticleRepository articleRepo;

  UpdateArticleBookmarkUsecase(this.articleRepo);

  @override
  Future<Either<Failure, int?>> call(ArticleBookmarkParam params) async {
    return await articleRepo.bookmarkArticle(params.articleEntity);
  }
}

class ArticleBookmarkParam implements NoParam {
  final ArticleEntity articleEntity;

  ArticleBookmarkParam({required this.articleEntity}) : super();

  @override
  List<Object?> get props => [articleEntity];

  @override
  bool? get stringify => throw UnimplementedError();
}
