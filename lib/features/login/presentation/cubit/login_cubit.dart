import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/features/login/domain/entities/userToken.dart';
import 'package:untitled/features/login/domain/use_cases/login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> userLogin(LoginParams params) async {
    emit(LoginLoadingState());
    Either<Failure, UserToken> response = await loginUseCase(params);
    emit(
      response.fold(
        (failure) => LoginErrorState(error: failure),
        (userToken) => LoginLoadedState(userToken: userToken)
      )
    );
  }
}
