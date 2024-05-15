import 'package:untitled/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:untitled/features/login/data/repositories/login_repository_impl.dart';
import 'package:untitled/features/login/domain/repositories/login_repository.dart';
import 'package:untitled/features/login/domain/use_cases/login.dart';
import 'package:untitled/features/login/presentation/cubit/login_cubit.dart';
import 'package:untitled/main.dart';

Future<void> loginDependencyInjectionInit() async {
  //! Features

  // Blocs
  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: sl()));

  // Use cases
  //We use lazy we don't need to load the whole app
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(loginRepository: sl()));

  // Repository
  //We use lazy we don't need to load the whole app
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
    networkInfo: sl(),
    loginRemoteDataSource: sl(),
  ));

  // Data Sources
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(apiConsumer: sl(),));

}