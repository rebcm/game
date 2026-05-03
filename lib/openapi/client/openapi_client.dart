import 'package:dio/dio.dart';

class OpenApiClient {
  final Dio _dio;

  OpenApiClient(this._dio);

  Future<Response> getEndpoint() async {
    return await _dio.get('https://example.com/api/endpoint');
  }
}
