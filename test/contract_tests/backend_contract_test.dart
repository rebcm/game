import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'fixtures/expected_response.json' as expected_response;

void main() {
  group('Backend Contract Tests', () {
    test('GET /api/endpoint returns 200', () async {
      final response = await http.get(Uri.parse('https://example.com/api/endpoint'));
      expect(response.statusCode, 200);
    });

    test('GET /api/endpoint returns expected JSON', () async {
      final response = await http.get(Uri.parse('https://example.com/api/endpoint'));
      final jsonData = jsonDecode(response.body);
      expect(jsonData, expected_response.data);
    });
  });
}
