import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/core/usecases/usecase.dart';
import 'package:untitled/features/gallery/domain/entities/upload.dart';
import 'package:untitled/features/gallery/domain/repositories/upload_repository.dart';

class GetImagesUseCase implements UseCase<UploadImage, TokenParams>{
  final UploadRepository uploadRepository;
  GetImagesUseCase({required this.uploadRepository});

  @override
  Future<Either<Failure, UploadImage>> call(TokenParams params) {
    return uploadRepository.getImages(params);
  }
}

class TokenParams extends Equatable{
  final String token;
  TokenParams({required this.token});
  
  @override
  List<Object?> get props => [token];
}