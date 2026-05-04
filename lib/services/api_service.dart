import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  Future<Response> get(String path) async {
    try {
      return await _dio.get('https://example.com$path');
    } on DioException catch (e) {
      throw e;
    }
  }
}
