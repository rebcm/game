import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('Endpoint Validation Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
    });

    test('Test endpoint response', () async {
      const url = 'https://example.com/api/test';
      dioAdapter.onGet(url, (server) {
        return server.reply(200, {'message': 'Success'});
      });

      final response = await dio.get(url);

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'Success'});
    });

    test('Test endpoint error response', () async {
      const url = 'https://example.com/api/error';
      dioAdapter.onGet(url, (server) {
        return server.reply(404, {'message': 'Not Found'});
      });

      final response = await dio.get(url);

      expect(response.statusCode, 404);
      expect(response.data, {'message': 'Not Found'});
    });
  });
}
