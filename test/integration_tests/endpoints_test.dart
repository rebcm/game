import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('Endpoints Test', () {
    test('Test endpoint response', () async {
      final dio = Dio();
      final dioAdapter = DioAdapter(dio: dio);

      dio.httpClientAdapter = dioAdapter;

      dioAdapter.onGet(
        'https://example.com/api/endpoint',
        (server) => server.reply(
          200,
          {'message': 'Success'},
        ),
      );

      final response = await dio.get('https://example.com/api/endpoint');

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'Success'});
    });
  });
}
