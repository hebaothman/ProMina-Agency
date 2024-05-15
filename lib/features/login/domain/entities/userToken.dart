import 'package:equatable/equatable.dart';
import 'package:untitled/features/login/domain/entities/user.dart';

class UserToken extends Equatable{
  User user;
  String token;

  UserToken({
    required this.user,
    required this.token,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [user, token];
}