import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/app_user_entity.dart';
import '../repository/auth_repository.dart';

class ForgotPasswordUseCase implements UseCase<AppUserEntity, AuthParam> {
  final AuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, AppUserEntity>> call(AuthParam params) async {
    return await authRepository.forgotPassword(params.email);
  }
}
