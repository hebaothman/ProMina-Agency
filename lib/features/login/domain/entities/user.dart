import 'package:equatable/equatable.dart';

class User extends Equatable{
  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, emailVerifiedAt, createdAt, updatedAt];

}