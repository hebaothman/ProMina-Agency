abstract class ApiConsumer {
  Future<dynamic> get(String path, String token, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path, {dynamic body, Map<String, dynamic>? queryParameters});
  Future<dynamic> uploadMultiPart(String path, String imagePath, String token);
}