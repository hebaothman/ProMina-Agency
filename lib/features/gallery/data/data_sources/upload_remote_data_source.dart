import 'dart:convert';
import 'package:untitled/core/api/api_consumer.dart';
import 'package:untitled/core/api/end_points.dart';
import 'package:untitled/features/gallery/data/models/upload_model.dart';
import 'package:untitled/features/gallery/domain/use_cases/upload.dart';
import 'package:untitled/features/login/data/models/userToken_model.dart';
import 'package:untitled/features/login/domain/use_cases/login.dart';

abstract class UploadRemoteDataSource{
  Future<UploadImageModel> upload(TokenImageParams params);
}

class UploadRemoteDataSourceImpl implements UploadRemoteDataSource {
  final ApiConsumer apiConsumer;
  UploadRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UploadImageModel> upload(TokenImageParams params) async {
    final response = await apiConsumer.uploadMultiPart(
      EndPoints.uploadImage,
      params.imagePath,
      params.token
    );
    return UploadImageModel.fromJson(response);
  }

}