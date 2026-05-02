import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  group('API Tests', () {
    final url = Uri.parse('https://construcao-criativa.workers.dev');

    test('GET request success', () async {
      final response = await http.get(url);
      expect(response.statusCode, 200);
    });

    test('GET request timeout', () async {
      final client = http.Client();
      try {
        await client.get(url).timeout(Duration(seconds: 1));
      } on TimeoutException {
        expect(true, isTrue);
      } catch (e) {
        fail('Unexpected exception: $e');
      } finally {
        client.close();
      }
    });

    test('GET request 404', () async {
      final invalidUrl = Uri.parse('https://construcao-criativa.workers.dev/invalid');
      final response = await http.get(invalidUrl);
      expect(response.statusCode, 404);
    });

    test('GET request invalid payload', () async {
      final invalidUrl = Uri.parse('https://construcao-criativa.workers.dev/invalid');
      final response = await http.get(invalidUrl);
      expect(response.body, isNot(contains('expected payload')));
    });
  });
}
