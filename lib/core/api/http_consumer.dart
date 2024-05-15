import 'dart:async';
import 'dart:convert';
import 'package:untitled/core/api/api_consumer.dart';
import 'package:untitled/core/api/status_code.dart';
import 'package:untitled/core/error/exceptions.dart';
import 'package:untitled/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HttpConsumer implements ApiConsumer{
  final http.Client client;
  final SharedPreferences sharedPreferences;

  HttpConsumer({required this.client, required this.sharedPreferences});

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(
        Uri.parse(path),
        headers: await _getToken()
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
        headers: await _getToken()
      );
      return _handleResponseErrors(response);
    }on TimeoutException catch(error){
      throw FetchDataException(error.toString());
    }on Exception catch(error){
      throw NoInternetConnectionException(error.toString());
    }
  }

  dynamic _handleResponseErrors(http.Response response) {
    String _message = '';
    if(response.statusCode != StatusCode.ok) {
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

  Future<dynamic> _getToken() async {
    var token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YTA0YWNmOGY5YWExNWVjZTgxNTFkNjI1MjgzNDQ2NCIsInN1YiI6IjY1ODU3Y2Y1NDNjZDU0NTUyYTNjMDg3MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jGgMWMKm5Q0xdfY9-5JO7QYAm5cKiGyIPTpguRpXYtE';
    return {AppStrings.contentType: AppStrings.applicationJson, AppStrings.charset: AppStrings.utf, AppStrings.authorization: token};
  }

}