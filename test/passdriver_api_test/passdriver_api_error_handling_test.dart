import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/passdriver_api.dart';

void main() {
  group('PassDriver API Error Handling', () {
    test('Handles 404 Not Found', () async {
      final response = await http.get(Uri.parse('https://api.passdriver.com/non-existent-endpoint'));
      expect(response.statusCode, 404);
    });

    test('Handles 500 Internal Server Error', () async {
      final response = await http.get(Uri.parse('https://api.passdriver.com/error-endpoint'));
      expect(response.statusCode, 500);
    });

    test('Handles network error', () async {
      try {
        await http.get(Uri.parse('https://non-existent-domain.com'));
        fail('Should throw an exception');
      } catch (e) {
        expect(e, isA<http.ClientException>());
      }
    });
  });
}
