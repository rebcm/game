import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';

void main() {
  group('API Test Strategy', () {
    test('should use mock API for unit tests', () {
      final dio = Dio();
      final dioAdapter = DioAdapter(dio: dio);
      expect(dioAdapter, isNotNull);
    });

    test('should use real API for integration tests', () async {
      final dio = Dio();
      final response = await dio.get('https://construcao-criativa.workers.dev/api/healthcheck');
      expect(response.statusCode, 200);
    });
  });
}
