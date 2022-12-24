import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/app_user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUserUseCase implements UseCase<AppUserEntity, AuthParam> {
  final AuthRepository authRepository;

  LoginUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, AppUserEntity>> call(AuthParam params) async {
    return await authRepository.loginUser(params.username, params.password);
  }
}
