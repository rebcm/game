import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/api/api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ApiClient', () {
    late http.Client httpClient;
    late ApiClient apiClient;

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = ApiClient(httpClient);
    });

    test('deve fazer uma requisição GET', () async {
      // Arrange
      when(() => httpClient.get(Uri.parse('https://example.com/api/data')))
          .thenAnswer((_) async => http.Response('{"data": "example"}', 200));

      // Act
      final response = await apiClient.getData();

      // Assert
      expect(response, '{"data": "example"}');
      verify(() => httpClient.get(Uri.parse('https://example.com/api/data'))).called(1);
    });
  });
}
