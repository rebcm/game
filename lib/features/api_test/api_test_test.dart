import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:passdriver/features/api_test/api_test.dart';

void main() {
  group('API Test', () {
    test('GET request', () async {
      final response = await http.get(Uri.parse('https://example.com/api/test'));
      expect(response.statusCode, 200);
    });
  });
}
