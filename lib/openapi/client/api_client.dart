import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Response> getEndpoint() async {
    return await _dio.get('https://example.com/api/endpoint');
  }
}
