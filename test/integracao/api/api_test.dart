import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('API Tests', () {
    test('GET /mundos', () async {
      final client = MockClient((request) async {
        if (request.url.path == '/mundos') {
          return http.Response('[]', 200);
        }
        return http.Response('Not Found', 404);
      });

      final response = await client.get(Uri.parse('${Constantes.urlApi}/mundos'));
      expect(response.statusCode, 200);
      expect(response.body, '[]');
    });

    test('POST /mundos', () async {
      final client = MockClient((request) async {
        if (request.url.path == '/mundos' && request.method == 'POST') {
          return http.Response('{"id": 1}', 201);
        }
        return http.Response('Not Found', 404);
      });

      final response = await client.post(
        Uri.parse('${Constantes.urlApi}/mundos'),
        headers: {'Content-Type': 'application/json'},
        body: '{"nome": "Novo Mundo"}',
      );
      expect(response.statusCode, 201);
      expect(response.body, '{"id": 1}');
    });

    test('GET /mundos/:id', () async {
      final client = MockClient((request) async {
        if (request.url.path == '/mundos/1') {
          return http.Response('{"id": 1, "nome": "Mundo"}', 200);
        }
        return http.Response('Not Found', 404);
      });

      final response = await client.get(Uri.parse('${Constantes.urlApi}/mundos/1'));
      expect(response.statusCode, 200);
      expect(response.body, '{"id": 1, "nome": "Mundo"}');
    });

    test('PUT /mundos/:id', () async {
      final client = MockClient((request) async {
        if (request.url.path == '/mundos/1' && request.method == 'PUT') {
          return http.Response('{"id": 1, "nome": "Mundo Atualizado"}', 200);
        }
        return http.Response('Not Found', 404);
      });

      final response = await client.put(
        Uri.parse('${Constantes.urlApi}/mundos/1'),
        headers: {'Content-Type': 'application/json'},
        body: '{"nome": "Mundo Atualizado"}',
      );
      expect(response.statusCode, 200);
      expect(response.body, '{"id": 1, "nome": "Mundo Atualizado"}');
    });

    test('DELETE /mundos/:id', () async {
      final client = MockClient((request) async {
        if (request.url.path == '/mundos/1' && request.method == 'DELETE') {
          return http.Response('', 204);
        }
        return http.Response('Not Found', 404);
      });

      final response = await client.delete(Uri.parse('${Constantes.urlApi}/mundos/1'));
      expect(response.statusCode, 204);
    });
  });
}
