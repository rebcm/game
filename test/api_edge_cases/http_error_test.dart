import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/api/api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late ApiClient apiClient;

  setUp(() {
    client = MockHttpClient();
    apiClient = ApiClient(client: client);
  });

  group('API Edge Cases', () {
    test('401 Unauthorized', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      expect(() async => await apiClient.fetchResource(),
          throwsA(isA<http.ClientException>()));
    });

    test('404 Not Found', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await apiClient.fetchResource(),
          throwsA(isA<http.ClientException>()));
    });

    test('500 Internal Server Error', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      expect(() async => await apiClient.fetchResource(),
          throwsA(isA<http.ClientException>()));
    });

    test('Connection instability', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenThrow(http.ClientException('Connection timed out'));

      expect(() async => await apiClient.fetchResource(),
          throwsA(isA<http.ClientException>()));
    });
  });
}
