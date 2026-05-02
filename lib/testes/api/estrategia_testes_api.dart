import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Testes de API', () {
    late http.Client client;

    setUp(() {
      client = MockHttpClient();
    });

    test('Teste de unidade com mock', () async {
      when(() => client.get(Uri.parse('https://api.example.com/dados')))
          .thenAnswer((_) async => http.Response('{"dados": "mockados"}', 200));

      final response = await client.get(Uri.parse('https://api.example.com/dados'));
      expect(response.statusCode, 200);
      expect(response.body, '{"dados": "mockados"}');
    });
  });
}
