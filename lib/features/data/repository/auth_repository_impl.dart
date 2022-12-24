import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entity/app_user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_user_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, AppUserEntity>> forgotPassword(String? email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> isLogged() {
    // TODO: implement isLogged
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUserEntity>> loginUser(
      String? email, String? password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUserEntity>> registerUser(
      String? email, String? username, String? password) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
