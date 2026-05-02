import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rebcm/api/cliente_api.dart';

void main() {
  test('Requisição GET bem-sucedida', () async {
    final cliente = ClienteApi('https://example.com/api/');
    final mockHttpClient = MockClient((request) async {
      return http.Response('{"message": "Sucesso"}', 200);
    });
    cliente._httpClient = mockHttpClient;

    final response = await cliente.fazerRequisicao('teste');

    expect(response.statusCode, 200);
    expect(response.body, '{"message": "Sucesso"}');
  });

  test('Requisição GET falha', () async {
    final cliente = ClienteApi('https://example.com/api/');
    final mockHttpClient = MockClient((request) async {
      return http.Response('Erro', 404);
    });
    cliente._httpClient = mockHttpClient;

    final response = await cliente.fazerRequisicao('teste');

    expect(response.statusCode, 404);
    expect(response.body, 'Erro');
  });
}
