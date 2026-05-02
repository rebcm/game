import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:passdriver/services/api.dart';

void main() {
  group('API Tests', () {
    test('GET request test', () async {
      final response = await http.get(Uri.parse('https://api.passdriver.com/test'));
      expect(response.statusCode, 200);
    });

    test('POST request test', () async {
      final response = await http.post(Uri.parse('https://api.passdriver.com/test'),
          body: {'key': 'value'});
      expect(response.statusCode, 201);
    });
  });
}
