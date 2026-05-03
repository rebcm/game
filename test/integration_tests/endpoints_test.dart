import 'package:flutter_test/flutter_test.dart';
import 'package:game/openapi/client/api_client.dart';
import 'dart:convert';

void main() {
  group('Endpoints Test', () {
    test('Test endpoint response', () async {
      final apiClient = ApiClient();
      final response = await apiClient.get('https://example.com/api/endpoint');

      expect(response.statusCode, 200);
      final jsonData = jsonDecode(response.body);
      expect(jsonData['key'], 'expected_value');
    });
  });
}
