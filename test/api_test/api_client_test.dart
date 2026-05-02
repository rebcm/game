import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/api/api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient _httpClient;
  late ApiClient _apiClient;

  setUp(() {
    _httpClient = MockHttpClient();
    _apiClient = ApiClient(_httpClient);
  });

  group('ApiClient', () {
    test('fetchData returns data when response is 200', () async {
      final response = http.Response('{"data": "test"}', 200);
      when(() => _httpClient.get(Uri.parse('https://example.com/api/data')))
          .thenAnswer((_) async => response);

      final result = await _apiClient.fetchData();
      expect(result, '{"data": "test"}');
    });

    test('fetchData throws exception when response is not 200', () async {
      final response = http.Response('Not Found', 404);
      when(() => _httpClient.get(Uri.parse('https://example.com/api/data')))
          .thenAnswer((_) async => response);

      expect(() async => await _apiClient.fetchData(), throwsException);
    });
  });
}
