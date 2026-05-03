import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Permissao Concedida Test', () {
    late http.Client client;

    setUp(() {
      client = MockHttpClient();
    });

    test('should return success when permission is granted', () async {
      when(() => client.get(Uri.parse('https://example.com/api/test')))
          .thenAnswer((_) async => http.Response('Success', 200));

      final response = await client.get(Uri.parse('https://example.com/api/test'));
      expect(response.statusCode, 200);
    });

    test('should return 403 when permission is denied', () async {
      when(() => client.get(Uri.parse('https://example.com/api/test')))
          .thenAnswer((_) async => http.Response('Forbidden', 403));

      final response = await client.get(Uri.parse('https://example.com/api/test'));
      expect(response.statusCode, 403);
    });
  });
}
