import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/core/usecases/usecase.dart';
import 'package:untitled/features/gallery/domain/entities/upload.dart';
import 'package:untitled/features/gallery/domain/repositories/upload_repository.dart';

class UploadUseCase implements UseCase<UploadImage, TokenImageParams>{
  final UploadRepository uploadRepository;
  UploadUseCase({required this.uploadRepository});

  @override
  Future<Either<Failure, UploadImage>> call(TokenImageParams params) {
    return uploadRepository.uploadImage(params);
  }
}

class TokenImageParams extends Equatable{
  final String token;
  final String imagePath;
  final String imageName;
  TokenImageParams({required this.token, required this.imagePath, required this.imageName});
  
  @override
  List<Object?> get props => [token];
}