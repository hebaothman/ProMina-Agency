import 'package:untitled/features/login/domain/entities/user.dart';
import 'package:untitled/features/login/domain/entities/userToken.dart';

class UserModel extends User {

  UserModel({
    required int id,
    required String name,
    required String email,
    required DateTime emailVerifiedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }): super(id: id, name: name, email: email, emailVerifiedAt: emailVerifiedAt, createdAt: createdAt, updatedAt: updatedAt);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

}