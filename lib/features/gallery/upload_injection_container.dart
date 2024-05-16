import 'package:untitled/features/gallery/data/data_sources/upload_remote_data_source.dart';
import 'package:untitled/features/gallery/data/repositories/upload_repository_impl.dart';
import 'package:untitled/features/gallery/domain/repositories/upload_repository.dart';
import 'package:untitled/features/gallery/domain/use_cases/upload.dart';
import 'package:untitled/features/gallery/presentation/cubit/upload_cubit.dart';
import 'package:untitled/main.dart';

Future<void> uploadDependencyInjectionInit() async {
  //! Features

  // Blocs
  sl.registerFactory<UploadCubit>(() => UploadCubit(uploadUseCase: sl()));

  // Use cases
  //We use lazy we don't need to load the whole app
  sl.registerLazySingleton<UploadUseCase>(() => UploadUseCase(uploadRepository: sl()));

  // Repository
  //We use lazy we don't need to load the whole app
  sl.registerLazySingleton<UploadRepository>(() => UploadRepositoryImpl(
    networkInfo: sl(),
    uploadRemoteDataSource: sl(),
  ));

  // Data Sources
  sl.registerLazySingleton<UploadRemoteDataSource>(() => UploadRemoteDataSourceImpl(apiConsumer: sl(),));

}