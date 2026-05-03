import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Server Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
    });

    test('should return 401 Unauthorized', () async {
      dioAdapter.onGet(
        'https://example.com/api/artefato',
        (server) => server.reply(401, {}),
      );

      final response = await dio.get('https://example.com/api/artefato');
      expect(response.statusCode, 401);
    });

    test('should return 403 Forbidden', () async {
      dioAdapter.onGet(
        'https://example.com/api/artefato',
        (server) => server.reply(403, {}),
      );

      final response = await dio.get('https://example.com/api/artefato');
      expect(response.statusCode, 403);
    });

    test('should return 507 Insufficient Storage', () async {
      dioAdapter.onGet(
        'https://example.com/api/artefato',
        (server) => server.reply(507, {}),
      );

      final response = await dio.get('https://example.com/api/artefato');
      expect(response.statusCode, 507);
    });
  });
}
