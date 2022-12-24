import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/app_user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUserEntity>> loginUser(
      String? email, String? password);

  Future<Either<Failure, AppUserEntity>> registerUser(
      String? email, String? username, String? password);

  Future<Either<Failure, AppUserEntity>> forgotPassword(String? email);

  Future<Either<Failure, bool>> isLogged();
}
