import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group('OpenAPI Contract Tests', () {
    test('GET /api/blocos', () async {
      final response = await http.get(Uri.parse('https://api.rebcm.com/api/blocos'));
      expect(response.statusCode, 200);
      final jsonData = jsonDecode(response.body);
      expect(jsonData, isA<List<dynamic>>());
      expect(jsonData.length, greaterThan(0));
    });

    test('GET /api/blocos/{id}', () async {
      final response = await http.get(Uri.parse('https://api.rebcm.com/api/blocos/1'));
      expect(response.statusCode, 200);
      final jsonData = jsonDecode(response.body);
      expect(jsonData, isA<Map<String, dynamic>>());
      expect(jsonData['id'], 1);
    });
  });
}
