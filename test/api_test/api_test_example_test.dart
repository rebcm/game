import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/api/api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client _httpClient;
  late ApiClient _apiClient;

  setUp(() {
    _httpClient = MockHttpClient();
    _apiClient = ApiClient(_httpClient);
  });

  group('ApiClient', () {
    test('should return data when the call is successful', () async {
      // Arrange
      when(() => _httpClient.get(Uri.parse('https://example.com/api/data')))
          .thenAnswer((_) async => http.Response('{"data": "example"}', 200));

      // Act
      final result = await _apiClient.getData();

      // Assert
      expect(result, 'example');
      verify(() => _httpClient.get(Uri.parse('https://example.com/api/data'))).called(1);
    });

    test('should throw an exception when the call fails', () async {
      // Arrange
      when(() => _httpClient.get(Uri.parse('https://example.com/api/data')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act and Assert
      expect(() async => await _apiClient.getData(), throwsException);
      verify(() => _httpClient.get(Uri.parse('https://example.com/api/data'))).called(1);
    });
  });
}
