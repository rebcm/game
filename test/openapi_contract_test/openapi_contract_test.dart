import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  group('OpenAPI Contract Test', () {
    test('Validate OpenAPI specification against the backend', () async {
      final openapiSpec = await File('assets/openapi/openapi.yaml').readAsString();
      final response = await http.get(Uri.parse('http://localhost:8080/v1/swagger.json'));

      expect(response.statusCode, 200);

      final jsonResponse = jsonDecode(response.body);
      final swaggerSpec = jsonEncode(jsonResponse);

      // Compare the OpenAPI spec with the backend's Swagger spec
      expect(swaggerSpec, isNotEmpty);
      // Implement a proper comparison or validation logic here
      // For simplicity, this example just checks if the specs are identical
      expect(swaggerSpec, openapiSpec);
    });
  });
}
