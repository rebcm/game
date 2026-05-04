import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> fetchData() async {
    return await _dio.get('https://example.com/api/data');
  }

  Future<Response> fetchDataWithError() async {
    return await _dio.get('https://example.com/api/error');
  }
}
