import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:passdriver/features/cloudflare_api/mock/cloudflare_mock_client.dart';

void main() {
  group('CloudflareMockClient', () {
    test('returns 401 response', () async {
      final client = CloudflareMockClient.with401();
      final response = await client._client.get(Uri.parse('https://example.com'));
      expect(response.statusCode, 401);
      expect(response.body, '{"error":"Token expirado"}');
    });

    test('returns 503 response', () async {
      final client = CloudflareMockClient.with503();
      final response = await client._client.get(Uri.parse('https://example.com'));
      expect(response.statusCode, 503);
      expect(response.body, '{"error":"Falha de conexão"}');
    });

    test('returns 413 response', () async {
      final client = CloudflareMockClient.with413();
      final response = await client._client.get(Uri.parse('https://example.com'));
      expect(response.statusCode, 413);
      expect(response.body, '{"error":"Payload Too Large"}');
    });
  });
}
