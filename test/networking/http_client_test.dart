import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:game/networking/http_client.dart';
import 'package:http/testing.dart';

void main() {
  test('GET request includes Accept-Encoding header', () async {
    final mockClient = MockClient((request) async {
      expect(request.headers['Accept-Encoding'], 'gzip');
      return http.Response('', 200);
    });
    final client = CustomHttpClient(mockClient);
    await client.get(Uri.parse('https://example.com'));
  });

  test('POST request includes Content-Encoding and Accept-Encoding headers', () async {
    final mockClient = MockClient((request) async {
      expect(request.headers['Content-Encoding'], 'gzip');
      expect(request.headers['Accept-Encoding'], 'gzip');
      return http.Response('', 200);
    });
    final client = CustomHttpClient(mockClient);
    await client.post(Uri.parse('https://example.com'));
  });
}
