import 'package:equatable/equatable.dart';

class AppUserEntity extends Equatable {
  final String? username;
  final String? email;
  final String? profileUrl;

  const AppUserEntity({
    this.username,
    this.email,
    this.profileUrl,
  }) : super();

  @override
  List<Object?> get props => [username, email, profileUrl];
}
