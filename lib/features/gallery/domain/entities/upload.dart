import 'package:equatable/equatable.dart';
import 'package:untitled/features/login/domain/entities/user.dart';

class UploadImage extends Equatable{
  String status;
  List<dynamic> data;
  String message;

  UploadImage({
    required this.status,
    required this.data,
    required this.message
  });

  @override
  List<Object?> get props => [status, data, message];
}