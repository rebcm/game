import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('Testes de API', () {
    test('Verificar se a biblioteca http_mock está configurada corretamente', () async {
      final client = MockClient((request) async {
        if (request.url.toString() == '${Constantes.urlApi}/endpoint') {
          return http.Response('{}', 200);
        }
        return http.Response('Not Found', 404);
      });

      final response = await client.get(Uri.parse('${Constantes.urlApi}/endpoint'));
      expect(response.statusCode, 200);
    });

    test('Testar se o mock funciona para chamadas de API', () async {
      final client = MockClient((request) async {
        return http.Response('{"key": "value"}', 200);
      });

      final response = await client.get(Uri.parse('${Constantes.urlApi}/mock'));
      expect(response.body, '{"key": "value"}');
    });
  });
}
