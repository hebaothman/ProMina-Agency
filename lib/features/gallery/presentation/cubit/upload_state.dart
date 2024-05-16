part of 'upload_cubit.dart';

@immutable
abstract class UploadState {}

class UploadInitial extends UploadState {}

class UploadLoadingState extends UploadState {}
class GetImagesLoadingState extends UploadState {}

class UploadLoadedState extends UploadState {
  final UploadImage uploadImage;
  UploadLoadedState({required this.uploadImage});
  List<Object> get props => [uploadImage];
}
class GetImagesLoadedState extends UploadState {
  final UploadImage uploadImage;
  GetImagesLoadedState({required this.uploadImage});
  List<Object> get props => [uploadImage];
}

class UploadErrorState extends UploadState {
  final Object error;
  UploadErrorState({required this.error});
  Object get props => error;
}
class GetImagesErrorState extends UploadState {
  final Object error;
  GetImagesErrorState({required this.error});
  Object get props => error;
}