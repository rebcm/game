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
    test('should return data when the response is 200', () async {
      // Arrange
      final response = http.Response('{"data": "some data"}', 200);
      when(() => _httpClient.get(any())).thenAnswer((_) async => response);

      // Act
      final result = await _apiClient.fetchData();

      // Assert
      expect(result, '{"data": "some data"}');
      verify(() => _httpClient.get(any())).called(1);
    });

    test('should throw an exception when the response is not 200', () async {
      // Arrange
      final response = http.Response('Not Found', 404);
      when(() => _httpClient.get(any())).thenAnswer((_) async => response);

      // Act and Assert
      expect(() async => await _apiClient.fetchData(), throwsException);
      verify(() => _httpClient.get(any())).called(1);
    });
  });
}
