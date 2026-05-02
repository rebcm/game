import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/testes/api/cliente_api.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ClienteApi', () {
    late http.Client client;
    late ClienteApi clienteApi;

    setUp(() {
      client = MockHttpClient();
      clienteApi = ClienteApi(client);
    });

    test('fazerChamadaApi retorna resposta válida', () async {
      final response = http.Response('{}', 200);
      when(() => client.get(any())).thenAnswer((_) async => response);

      final resultado = await clienteApi.fazerChamadaApi('teste');
      expect(resultado.statusCode, 200);
      verify(() => client.get(any())).called(1);
    });
  });
}
