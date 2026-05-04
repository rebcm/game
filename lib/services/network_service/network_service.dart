import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio;

  NetworkService(this._dio);

  Future<bool> checkNetworkConnection() async {
    try {
      final response = await _dio.get('https://example.com/check_connection');
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }
}
