import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('Upload Stress Test', () {
    test('Large File Upload', () async {
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          final length = request.contentLength ?? 0;
          expect(length, greaterThan(0));
          await request.read().drain();
          return http.Response('OK', 200);
        }
        return http.Response('Not Found', 404);
      });

      final largeFile = List.generate(Constantes.maxUploadSize, (index) => index % 256);
      final response = await client.post(Uri.parse('https://example.com/upload'), body: largeFile);

      expect(response.statusCode, 200);
    });

    test('File Larger Than Allowed', () async {
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          final length = request.contentLength ?? 0;
          expect(length, greaterThan(Constantes.maxUploadSize));
          await request.read().drain();
          return http.Response('Payload Too Large', 413);
        }
        return http.Response('Not Found', 404);
      });

      final veryLargeFile = List.generate(Constantes.maxUploadSize + 1, (index) => index % 256);
      final response = await client.post(Uri.parse('https://example.com/upload'), body: veryLargeFile);

      expect(response.statusCode, 413);
    });
  });
}
