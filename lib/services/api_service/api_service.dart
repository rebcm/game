import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<http.Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return http.Response(
        response.data.toString(),
        response.statusCode ?? 500,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Timeout');
      } else {
        throw Exception('Error ${e.response?.statusCode}');
      }
    }
  }
}
