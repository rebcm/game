import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/nome_endpoint.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Nome Endpoint', () {
    late http.Client client;
    late NomeEndpoint endpoint;

    setUp(() {
      client = MockHttpClient();
      endpoint = NomeEndpoint(client);
    });

    test('não aceita nomes duplicados', () async {
      when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"error": "Nome já existe"}', 400));

      final resultado = await endpoint.criarNome('nomeExistente');
      expect(resultado, isFalse);
    });

    test('aceita nomes não duplicados', () async {
      when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"message": "Nome criado com sucesso"}', 201));

      final resultado = await endpoint.criarNome('nomeNovo');
      expect(resultado, isTrue);
    });
  });
}
