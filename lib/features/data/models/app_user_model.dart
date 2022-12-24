import '../../domain/entity/app_user_entity.dart';

class AppUserModel extends AppUserEntity {
  const AppUserModel({
    super.username,
    super.email,
    super.profileUrl,
  }) : super();
}
