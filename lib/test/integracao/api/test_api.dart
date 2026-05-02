import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/config/constantes.dart';
import 'package:http_mock/http_mock.dart';

void main() {
  group('Testes de Integração da API', () {
    test('GET /healthcheck', () async {
      final response = await http.get(Uri.parse('$URL_API/healthcheck'));
      expect(response.statusCode, 200);
      expect(response.body, 'OK');
    });

    test('GET /healthcheck com mock', () async {
      final client = MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/healthcheck');
        return Response('OK', 200);
      });

      final response = await client.get(Uri.parse('$URL_API/healthcheck'));
      expect(response.statusCode, 200);
      expect(response.body, 'OK');
    });

    test('Tratamento de exceção na API', () async {
      final client = MockClient((request) async {
        return Response('Erro interno', 500);
      });

      expect(() async => await client.get(Uri.parse('$URL_API/healthcheck')),
          throwsException);
    });
  });
}
