import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/api/api.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('API Tests', () {
    late http.Client client;
    late Api api;

    setUp(() {
      client = MockHttpClient();
      api = Api(client);
    });

    test('Testa chamada à API', () async {
      when(() => client.get(Uri.parse('https://example.com/api/endpoint')))
          .thenAnswer((_) async => http.Response('{"key": "value"}', 200));

      final response = await api.chamadaApi();

      expect(response, '{"key": "value"}');
      verify(() => client.get(Uri.parse('https://example.com/api/endpoint'))).called(1);
    });
  });
}
