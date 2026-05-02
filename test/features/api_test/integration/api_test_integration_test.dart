import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:passdriver/features/api_test/data/api_client.dart';

void main() {
  group('API Integration Tests', () {
    late http.Client client;

    setUp(() {
      client = http.Client();
    });

    tearDown(() {
      client.close();
    });

    test('should return 200 for valid endpoint', () async {
      final response = await client.get(Uri.parse('https://example.com/api/endpoint'));
      expect(response.statusCode, 200);
    });

    test('should return error for invalid endpoint', () async {
      final response = await client.get(Uri.parse('https://example.com/api/invalid-endpoint'));
      expect(response.statusCode, 404);
    });
  });
}
