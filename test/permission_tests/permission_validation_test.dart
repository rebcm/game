import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Testes de permissão', () {
    late http.Client client;

    setUp(() {
      client = MockHttpClient();
    });

    test('Permissão concedida deve resultar em sucesso', () async {
      when(() => client.get(Uri.parse('https://example.com/api/test')))
          .thenAnswer((_) async => http.Response('Success', 200));

      final response = await client.get(Uri.parse('https://example.com/api/test'));
      expect(response.statusCode, 200);
    });

    test('Permissão negada deve resultar em erro 403', () async {
      when(() => client.get(Uri.parse('https://example.com/api/test')))
          .thenAnswer((_) async => http.Response('Forbidden', 403));

      final response = await client.get(Uri.parse('https://example.com/api/test'));
      expect(response.statusCode, 403);
    });
  });
}
