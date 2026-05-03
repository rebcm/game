import 'package:dio/dio.dart';

class OpenApiClient {
  final Dio _dio;

  OpenApiClient(this._dio);

  Future<Response> healthcheck() async {
    return await _dio.get('/healthcheck');
  }
}
