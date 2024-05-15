import 'package:untitled/features/login/data/models/user_model.dart';
import 'package:untitled/features/login/domain/entities/user.dart';
import 'package:untitled/features/login/domain/entities/userToken.dart';

class UserTokenModel extends UserToken {
  UserTokenModel({required User user, required String token}): super(user: user, token: token);

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => UserTokenModel(
    user: UserModel.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": UserModel(id: user.id, name: user.name, email: user.email, emailVerifiedAt: user.emailVerifiedAt, createdAt: user.createdAt, updatedAt: user.updatedAt),
    "token": token,
  };

}