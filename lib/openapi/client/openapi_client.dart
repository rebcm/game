import 'package:dio/dio.dart';

class OpenAPIClient {
  final Dio _dio;

  OpenAPIClient(this._dio);

  Future<Response> getTestEndpoint() async {
    try {
      final response = await _dio.get('/test-endpoint');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
