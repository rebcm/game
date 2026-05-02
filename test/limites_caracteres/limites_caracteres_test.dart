import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';

void main() {
  group('Testes de limites de caracteres no endpoint', () {
    test('Input dentro do limite de caracteres deve ser aceito', () async {
      final client = MockClient((request) async {
        if (request.body.length <= 100) {
          return http.Response('OK', 200);
        } else {
          return http.Response('Erro', 400);
        }
      });

      final response = await client.post(Uri.parse('https://example.com/api'),
          body: 'a' * 50);

      expect(response.statusCode, 200);
    });

    test('Input fora do limite de caracteres deve ser rejeitado', () async {
      final client = MockClient((request) async {
        if (request.body.length <= 100) {
          return http.Response('OK', 200);
        } else {
          return http.Response('Erro', 400);
        }
      });

      final response = await client.post(Uri.parse('https://example.com/api'),
          body: 'a' * 150);

      expect(response.statusCode, 400);
    });
  });
}
