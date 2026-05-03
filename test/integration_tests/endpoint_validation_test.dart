import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/openapi/client.dart';

void main() {
  group('Endpoint Validation Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
    });

    test('Test endpoint response', () async {
      const path = '/test-endpoint';
      const responseBody = {'message': 'success'};

      dioAdapter.onGet(
        path,
        (server) => server.reply(200, responseBody),
      );

      final response = await dio.get(path);

      expect(response.statusCode, 200);
      expect(response.data, responseBody);
    });

    // Add more tests for other endpoints here
  });
}
