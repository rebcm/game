import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/api/client.dart';

void main() {
  group('API Edge Cases', () {
    test('null input handling', () async {
      final client = ApiClient(http.Client());
      expect(() => client.fetchData(null), throwsArgumentError);
    });

    test('expired token handling', () async {
      final mockHttpClient = MockHttpClient();
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api/data')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));
      final client = ApiClient(mockHttpClient);
      expect(() => client.fetchData('expired-token'), throwsException);
    });

    test('character limit handling', () async {
      final mockHttpClient = MockHttpClient();
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api/data')))
          .thenAnswer((_) async => http.Response('OK', 200));
      final client = ApiClient(mockHttpClient);
      expect(() => client.fetchData('a' * 1001), throwsArgumentError);
    });

    test('network instability handling', () async {
      final mockHttpClient = MockHttpClient();
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api/data')))
          .thenThrow(SocketException('Connection failed'));
      final client = ApiClient(mockHttpClient);
      expect(() => client.fetchData('token'), throwsException);
    });
  });
}
