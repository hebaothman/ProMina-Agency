import 'package:dartz/dartz.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/features/gallery/domain/entities/upload.dart';
import 'package:untitled/features/gallery/domain/use_cases/get_images.dart';
import 'package:untitled/features/gallery/domain/use_cases/upload.dart';

abstract class UploadRepository {
  Future<Either<Failure, UploadImage>> uploadImage(TokenImageParams params);
  Future<Either<Failure, UploadImage>> getImages(TokenParams params);
}