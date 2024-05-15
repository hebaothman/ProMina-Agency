import 'dart:convert';
import 'package:untitled/core/api/api_consumer.dart';
import 'package:untitled/core/api/end_points.dart';
import 'package:untitled/features/login/data/models/userToken_model.dart';
import 'package:untitled/features/login/domain/use_cases/login.dart';

abstract class LoginRemoteDataSource{
  Future<UserTokenModel> login(LoginParams params);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiConsumer apiConsumer;
  LoginRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserTokenModel> login(LoginParams params) async{
    final response = await apiConsumer.post(
      EndPoints.login,
      body: jsonEncode({
        "email": params.email,
        "password": params.password
      }),
    );
    return UserTokenModel.fromJson(json.decode(response.body.toString()));
  }

}