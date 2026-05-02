import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/api/api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client _client;
  late ApiClient _apiClient;

  setUp(() {
    _client = MockHttpClient();
    _apiClient = ApiClient(_client);
  });

  group('ApiClient', () {
    test('get returns response', () async {
      final response = http.Response('{}', 200);
      when(() => _client.get(any())).thenAnswer((_) async => response);

      final result = await _apiClient.get(Uri.parse('https://example.com'));

      expect(result.statusCode, 200);
    });

    test('post returns response', () async {
      final response = http.Response('{}', 200);
      when(() => _client.post(any())).thenAnswer((_) async => response);

      final result = await _apiClient.post(Uri.parse('https://example.com'));

      expect(result.statusCode, 200);
    });
  });
}
