import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/core/usecases/usecase.dart';
import 'package:untitled/features/login/domain/entities/userToken.dart';
import 'package:untitled/features/login/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<UserToken, LoginParams>{
  final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, UserToken>> call(LoginParams params) {
    return loginRepository.userLogin(params);
  }
}

class LoginParams extends Equatable{
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
  
  @override
  List<Object?> get props => [email, password];
}