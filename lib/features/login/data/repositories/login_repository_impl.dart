import 'package:dartz/dartz.dart';
import 'package:untitled/core/error/exceptions.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/core/network/network_info.dart';
import 'package:untitled/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:untitled/features/login/domain/entities/userToken.dart';
import 'package:untitled/features/login/domain/repositories/login_repository.dart';
import 'package:untitled/features/login/domain/use_cases/login.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.networkInfo, required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, UserToken>> userLogin(LoginParams params) async {
    try {
      final login = await loginRemoteDataSource.login(params);
      return Right(login);
    } on ServerException catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
}