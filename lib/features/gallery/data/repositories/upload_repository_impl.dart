import 'package:dartz/dartz.dart';
import 'package:untitled/core/error/exceptions.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/core/network/network_info.dart';
import 'package:untitled/features/gallery/data/data_sources/upload_remote_data_source.dart';
import 'package:untitled/features/gallery/domain/entities/upload.dart';
import 'package:untitled/features/gallery/domain/repositories/upload_repository.dart';
import 'package:untitled/features/gallery/domain/use_cases/upload.dart';

class UploadRepositoryImpl implements UploadRepository {
  final NetworkInfo networkInfo;
  final UploadRemoteDataSource uploadRemoteDataSource;

  UploadRepositoryImpl({required this.networkInfo, required this.uploadRemoteDataSource});

  @override
  Future<Either<Failure, UploadImage>> uploadImage(TokenImageParams params) async {
    try {
      final upload = await uploadRemoteDataSource.upload(params);
      return Right(upload);
    } on ServerException catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }


}