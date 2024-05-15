import 'package:dartz/dartz.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/features/login/domain/entities/userToken.dart';
import 'package:untitled/features/login/domain/use_cases/login.dart';

abstract class LoginRepository {
  //Any of these methods can return either failure or data
  Future<Either<Failure, UserToken>> userLogin(LoginParams params);
}