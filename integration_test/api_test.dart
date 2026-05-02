import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/api/api.dart';

void main() {
  group('API Integration Tests', () {
    test('GET request success', () async {
      final response = await http.get(Uri.parse('https://construcao-criativa.workers.dev/api/test'));
      expect(response.statusCode, 200);
    });

    test('GET request failure - 404', () async {
      final response = await http.get(Uri.parse('https://construcao-criativa.workers.dev/api/non-existent'));
      expect(response.statusCode, 404);
    });

    test('GET request failure - timeout', () async {
      expect(() async {
        await http.get(Uri.parse('https://construcao-criativa.workers.dev/api/test'),
            headers: {'timeout': '1'}).timeout(Duration(seconds: 1));
      }, throwsA(isA<TimeoutException>()));
    });
  });
}
