import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('API Integration Tests', () {
    late http.Client client;

    setUp(() {
      client = http.Client();
    });

    tearDown(() {
      client.close();
    });

    test('GET /mundos sincroniza mundos corretamente', () async {
      final response = await client.get(Uri.parse('${Constantes.urlApi}/mundos'));
      expect(response.statusCode, 200);
    });

    test('POST /mundos cria mundo corretamente', () async {
      final response = await client.post(
        Uri.parse('${Constantes.urlApi}/mundos'),
        headers: {'Content-Type': 'application/json'},
        body: '{"nome": "Novo Mundo"}',
      );
      expect(response.statusCode, 201);
    });

    test('PUT /mundos/:id atualiza mundo corretamente', () async {
      final response = await client.put(
        Uri.parse('${Constantes.urlApi}/mundos/1'),
        headers: {'Content-Type': 'application/json'},
        body: '{"nome": "Mundo Atualizado"}',
      );
      expect(response.statusCode, 200);
    });

    test('DELETE /mundos/:id deleta mundo corretamente', () async {
      final response = await client.delete(Uri.parse('${Constantes.urlApi}/mundos/1'));
      expect(response.statusCode, 204);
    });

    test('GET /mundos/:id retorna mundo corretamente', () async {
      final response = await client.get(Uri.parse('${Constantes.urlApi}/mundos/1'));
      expect(response.statusCode, 200);
    });

    test('Tratamento de exceção para endpoint inexistente', () async {
      final response = await client.get(Uri.parse('${Constantes.urlApi}/endpoint-inexistente'));
      expect(response.statusCode, 404);
    });
  });

  group('API Mock Tests', () {
    late MockClient client;

    setUp(() {
      client = MockClient((request) async {
        if (request.url.path == '/mundos') {
          return http.Response('[]', 200);
        } else if (request.url.path == '/mundos/1') {
          return http.Response('{"id": 1, "nome": "Mundo Mockado"}', 200);
        }
        return http.Response('', 404);
      });
    });

    test('GET /mundos sincroniza mundos corretamente com mock', () async {
      final response = await client.get(Uri.parse('${Constantes.urlApi}/mundos'));
      expect(response.statusCode, 200);
    });

    test('GET /mundos/:id retorna mundo corretamente com mock', () async {
      final response = await client.get(Uri.parse('${Constantes.urlApi}/mundos/1'));
      expect(response.statusCode, 200);
      expect(response.body, '{"id": 1, "nome": "Mundo Mockado"}');
    });
  });
}
