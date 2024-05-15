part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final UserToken userToken;
  LoginLoadedState({required this.userToken});
  List<Object> get props => [userToken];
}

class LoginErrorState extends LoginState {
  final Object error;
  LoginErrorState({required this.error});
  Object get props => error;
}
