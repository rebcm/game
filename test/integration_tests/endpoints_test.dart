import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group('Endpoints Test', () {
    test('Test endpoint response', () async {
      final response = await http.get(Uri.parse('https://example.com/api/endpoint'));
      expect(response.statusCode, 200);
      final jsonData = jsonDecode(response.body);
      expect(jsonData, isNotNull);
    });
  });
}
