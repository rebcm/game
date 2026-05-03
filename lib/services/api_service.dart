import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<dynamic> fetchData(String url) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }
}
