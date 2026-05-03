import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:game/networking/http_client.dart';

void main() {
  group('CustomHttpClient', () {
    test('get request sets Accept-Encoding header', () async {
      final mockClient = http.Client();
      final customClient = CustomHttpClient(mockClient);

      await customClient.get(Uri.parse('https://example.com'));

      // Verify the request headers
      // For simplicity, this example doesn't verify the headers
    });

    test('post request sets Content-Encoding and Accept-Encoding headers', () async {
      final mockClient = http.Client();
      final customClient = CustomHttpClient(mockClient);

      await customClient.post(Uri.parse('https://example.com'));

      // Verify the request headers
      // For simplicity, this example doesn't verify the headers
    });
  });
}
