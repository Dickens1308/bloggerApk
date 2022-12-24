import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class NoParam extends Equatable {}

class ArticleParam implements NoParam {
  final int? page;

  ArticleParam({this.page}) : super();

  @override
  List<Object?> get props => [page];

  @override
  bool? get stringify => throw UnimplementedError();
}

class AuthParam extends NoParam {
  final String? username;
  final String? email;
  final String? password;

  AuthParam({this.username, this.email, this.password});

  @override
  List<Object?> get props => [username, email, password];
}
