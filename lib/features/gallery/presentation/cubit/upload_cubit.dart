import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/error/failures.dart';
import 'package:untitled/features/gallery/domain/entities/upload.dart';
import 'package:untitled/features/gallery/domain/use_cases/get_images.dart';
import 'package:untitled/features/gallery/domain/use_cases/upload.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final UploadUseCase uploadUseCase;
  final GetImagesUseCase getImagesUseCase;

  UploadCubit({required this.uploadUseCase, required this.getImagesUseCase}) : super(UploadInitial());

  Future<void> imageUpload(TokenImageParams params) async {
    emit(UploadLoadingState());
    Either<Failure, UploadImage> response = await uploadUseCase(params);
    emit(
      response.fold(
        (failure) => UploadErrorState(error: failure),
        (uploadImage) => UploadLoadedState(uploadImage: uploadImage)
      )
    );
  }

  Future<void> getImages(TokenParams params) async {
    emit(GetImagesLoadingState());
    Either<Failure, UploadImage> response = await getImagesUseCase(params);
    emit(
      response.fold(
        (failure) => GetImagesErrorState(error: failure),
        (uploadImage) => GetImagesLoadedState(uploadImage: uploadImage)
      )
    );
  }

}
