import 'package:test/test.dart';
import 'package:dio/dio.dart';

void main() {
  group('API Unit Tests', () {
    test('Test API Client', () async {
      final dio = Dio();
      final response = await dio.get('https://example.com/api/healthcheck');
      expect(response.statusCode, 200);
    });

    test('Test API Error Handling', () async {
      final dio = Dio();
      try {
        await dio.get('https://example.com/api/non-existent');
        fail('Should have thrown an exception');
      } on DioException catch (e) {
        expect(e.response?.statusCode, 404);
      }
    });
  });
}
