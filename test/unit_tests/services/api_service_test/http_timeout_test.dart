import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/api_service.dart';

void main() {
  group('ApiService HTTP Timeout Test', () {
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
    });

    test('should throw timeout error when delay exceeds timeout', () async {
      const path = '/test-timeout';
      dio.httpClientAdapter = dioAdapter;

      dioAdapter.onGet(
        Uri.parse('https://example.com$path'),
        (server) => server.reply(200, {'message': 'success'}),
        delay: const Duration(seconds: 10),
      );

      final apiService = ApiService(dio: dio);

      expect(
        () => apiService.get(path),
        throwsA(isA<DioException>().having(
          (e) => e.type,
          'type',
          DioExceptionType.connectionTimeout,
        )),
      );
    });
  });
}
