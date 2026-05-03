import 'package:dio/dio.dart';

class OpenAPIClient {
  final Dio _dio;

  OpenAPIClient({required Dio dio}) : _dio = dio;

  Future<Response> someEndpoint() async {
    // Implement the actual API call here
    return _dio.get('/some-endpoint');
  }
}
