import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/core/api/api_consumer.dart';
import 'package:untitled/core/api/status_code.dart';
import 'package:untitled/core/error/exceptions.dart';
import 'package:untitled/core/utils/app_strings.dart';

class HttpConsumer implements ApiConsumer{
  final http.Client client;
  final SharedPreferences sharedPreferences;

  HttpConsumer({required this.client, required this.sharedPreferences});

  @override
  Future get(String path, String token, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(
        Uri.parse(path),
      );
      return _handleResponseErrors(response);
    }on TimeoutException catch(error){
      throw FetchDataException(error.toString());
    }on Exception catch(error){
      throw NoInternetConnectionException(error.toString());
    }
  }

  @override
  Future post(String path, {dynamic body, Map<String, dynamic>? queryParameters}) async { //Map<String, dynamic>
    try {
      final response = await client.post(
        Uri.parse(path),
        body: body,
        headers: _getToken(body)
      );
      return _handleResponseErrors(response);
    }on TimeoutException catch(error){
      throw FetchDataException(error.toString());
    }on Exception catch(error){
      throw NoInternetConnectionException(error.toString());
    }
  }

  Future uploadMultiPart(String path, String imagePath, String token) async {
    try {
      var results = http.MultipartRequest('POST', Uri.parse(path), );
      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath('img', imagePath);
      //add multipart to request
      results.files.add(pic);
      Map<String, String> _headers = {AppStrings.contentType: AppStrings.applicationJson, AppStrings.charset: AppStrings.utf, AppStrings.authorization: "Bearer "+ token};
      results.headers.addAll(_headers);
      var response = await results.send();
      //Handling Errors
      final String respStr = await response.stream.bytesToString();
      switch (response.statusCode){
        case StatusCode.ok:
          return jsonDecode(respStr);
        case StatusCode.badRequest:
          throw BadRequestException(jsonDecode(respStr)['message']);
        case StatusCode.unauthorized:
        case StatusCode.forbidden:
          throw UnauthorizedException(jsonDecode(respStr)['message']);
        case StatusCode.notFound:
          throw NotFoundException(jsonDecode(respStr)['message']);
        case StatusCode.conflict:
          throw ConflictException(jsonDecode(respStr)['message']);
        case StatusCode.internalServerError:
          throw InternalServerErrorException(jsonDecode(respStr)['message']);
      }
    }on TimeoutException catch(error){
      throw FetchDataException(error.toString());
    }on Exception catch(error){
      throw NoInternetConnectionException(error.toString());
    }
  }

  dynamic _handleResponseErrors(http.Response response) {
    String _message = '';
    if(response.statusCode != StatusCode.ok && response.body != "") {
      _message = (jsonDecode(response.body)['Message']).toString();
    }
    switch (response.statusCode){
      case StatusCode.ok:
        return response;
      case StatusCode.badRequest:
        throw BadRequestException(_message);
      case StatusCode.unauthorized:
      case StatusCode.forbidden:
        throw UnauthorizedException(_message);
      case StatusCode.notFound:
        throw NotFoundException(_message);
      case StatusCode.conflict:
        throw ConflictException(_message);
      case StatusCode.internalServerError:
        throw InternalServerErrorException(_message);
    }
  }

  dynamic _getToken(String token) {
    return {AppStrings.contentType: AppStrings.applicationJson, AppStrings.charset: AppStrings.utf, AppStrings.authorization: token};
  }

}