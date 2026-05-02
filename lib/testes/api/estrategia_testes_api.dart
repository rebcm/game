import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:rebcm/api/cliente_api.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Testes de API', () {
    late http.Client client;
    late ClienteApi clienteApi;

    setUp(() {
      client = MockHttpClient();
      clienteApi = ClienteApi(client);
    });

    test('requisição GET bem-sucedida', () async {
      when(() => client.get(Uri.parse('https://api.exemplo.com/dados')))
        .thenAnswer((_) async => http.Response('{"dados": "valor"}', 200));

      final resposta = await clienteApi.obterDados();
      expect(resposta.statusCode, 200);
      expect(resposta.body, '{"dados": "valor"}');
    });

    test('requisição GET falha', () async {
      when(() => client.get(Uri.parse('https://api.exemplo.com/dados')))
        .thenAnswer((_) async => http.Response('Erro', 404));

      final resposta = await clienteApi.obterDados();
      expect(resposta.statusCode, 404);
      expect(resposta.body, 'Erro');
    });
  });
}
