import '../models/app_user_model.dart';

abstract class AuthDataSource {
  Future<AppUserModel> loginUser(String email, String pass);

  Future<AppUserModel> registerUser(String email, String username, String pass);

  Future<void> logoutUser();

  Future<void> forgotPassword();
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<void> forgotPassword() {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel> loginUser(String email, String pass) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel> registerUser(
      String email, String username, String pass) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
