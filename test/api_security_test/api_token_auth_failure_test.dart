import 'package:flutter_test/flutter_test.dart';
import 'package:game/api_client.dart';
import 'package:dio/dio.dart';

void main() {
  test('API token authentication failure test', () async {
    final dio = Dio();
    final client = ApiClient(dio);
    dio.options.headers['Authorization'] = 'Bearer invalid_token';
    try {
      await client.makeRequest();
      fail('Should have thrown an exception');
    } on DioException catch (e) {
      expect(e.response?.statusCode, 401);
    }
  });
}
