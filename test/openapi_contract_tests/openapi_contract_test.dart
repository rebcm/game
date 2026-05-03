import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:game/openapi/client.dart';

void main() {
  group('OpenAPI Contract Tests', () {
    late OpenAPIClient client;

    setUp(() {
      client = OpenAPIClient(http.Client());
    });

    test('should validate OpenAPI documentation against backend', () async {
      final response = await client.validateOpenAPI();
      expect(response.statusCode, 200);
    });
  });
}
