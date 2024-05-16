import 'package:untitled/features/gallery/domain/entities/upload.dart';

class UploadImageModel extends UploadImage {
  UploadImageModel({required String status, required List<dynamic> data, required String message,}): super(status: status, data: data, message: message);

  factory UploadImageModel.fromJson(Map<String, dynamic> json) => UploadImageModel(
    status: json["status"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
  };

}