import 'package:dio/dio.dart';

class OpenAPIClient {
  final Dio _dio;

  OpenAPIClient(this._dio);

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}
