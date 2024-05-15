import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    print(reason);
    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      print("Retrying request...");
      final cache = await SharedPreferences.getInstance();
      // cache.setString(appToken, OPEN_WEATHER_API_KEY);

      return true;
    }
    return false;
  }

}