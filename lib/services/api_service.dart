import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<bool> checkCloudflareConnectivity() async {
    try {
      final response = await _dio.get('https://example.com'); // Update with actual URL
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
