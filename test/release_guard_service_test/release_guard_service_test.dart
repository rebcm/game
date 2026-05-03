import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/release_guard_service.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  dotenv.testEnv = {'API_URL': 'https://example.com/api'};

  group('ReleaseGuardService', () {
    test('should return true for protected tags', () async {
      final dio = http.Client();
      final dioAdapter = DioAdapter(dio: dio);

      dioAdapter.onGet(
        'https://example.com/api/protected-tags/release-1.0',
        (server) => server.reply(200, 'true'),
      );

      final service = ReleaseGuardService();
      final result = await service.isProtectedTag('release-1.0');

      expect(result, true);
    });

    test('should return false for non-protected tags', () async {
      final dio = http.Client();
      final dioAdapter = DioAdapter(dio: dio);

      dioAdapter.onGet(
        'https://example.com/api/protected-tags/non-release-tag',
        (server) => server.reply(200, 'false'),
      );

      final service = ReleaseGuardService();
      final result = await service.isProtectedTag('non-release-tag');

      expect(result, false);
    });
  });
}
