import 'package:flutter/material.dart';

import '../../domain/usecase/forgot_password_use_case.dart';
import '../../domain/usecase/login_user_use_case.dart';
import '../../domain/usecase/register_user_use_case.dart';

class AuthProvider extends ChangeNotifier {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final LoginUserUseCase loginUserUseCase;
  final RegisterUserUseCase registerUserUseCase;

  AuthProvider({
    required this.forgotPasswordUseCase,
    required this.loginUserUseCase,
    required this.registerUserUseCase,
  });
}
