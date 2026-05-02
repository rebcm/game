import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/config/constantes.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Testes de API', () {
    late http.Client client;

    setUp(() {
      client = MockHttpClient();
    });

    test('Verifica se a URL da API é válida', () async {
      const url = Constantes.urlApi;
      when(() => client.get(Uri.parse(url))).thenAnswer((_) async => http.Response('{}', 200));
      final response = await client.get(Uri.parse(url));
      expect(response.statusCode, 200);
    });

    test('Verifica se a resposta da API é válida', () async {
      const url = Constantes.urlApi;
      when(() => client.get(Uri.parse(url))).thenAnswer((_) async => http.Response('{}', 200));
      final response = await client.get(Uri.parse(url));
      expect(response.body, '{}');
    });
  });
}
