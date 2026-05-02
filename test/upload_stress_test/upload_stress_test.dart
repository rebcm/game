import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('Upload Stress Test', () {
    test('Upload large file', () async {
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          final contentLength = request.headers['content-length'];
          if (contentLength != null) {
            final length = int.parse(contentLength);
            expect(length, lessThanOrEqualTo(Constantes.maxUploadSize));
          }
          return http.Response('OK', 200);
        }
        return http.Response('Not Found', 404);
      });

      final largeFile = List<int>.generate(Constantes.maxUploadSize, (i) => i % 256);
      final response = await client.post(Uri.parse('https://example.com/upload'), body: largeFile);

      expect(response.statusCode, 200);
    });

    test('Upload file larger than allowed', () async {
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          final contentLength = request.headers['content-length'];
          if (contentLength != null) {
            final length = int.parse(contentLength);
            expect(length, greaterThan(Constantes.maxUploadSize));
          }
          return http.Response('Payload Too Large', 413);
        }
        return http.Response('Not Found', 404);
      });

      final largerFile = List<int>.generate(Constantes.maxUploadSize + 1, (i) => i % 256);
      final response = await client.post(Uri.parse('https://example.com/upload'), body: largerFile);

      expect(response.statusCode, 413);
    });
  });
}
