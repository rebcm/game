import 'package:dio/dio.dart';

class OpenApiClient {
  final Dio _dio;

  OpenApiClient(this._dio);

  Future<Response> testApi() async {
    return await _dio.get('/api/test');
  }
}
