import 'package:dio/dio.dart';

class OpenApiClient {
  final Dio _dio;

  OpenApiClient(this._dio);

  Future<Response> getDocs() async {
    return await _dio.get('/docs');
  }

  Future<Response> getOpenApiJson() async {
    return await _dio.get('/openapi.json');
  }
}
