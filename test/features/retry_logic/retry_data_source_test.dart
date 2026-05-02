import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:passdriver/features/retry_logic/data/retry_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('RetryDataSource', () {
    late http.Client client;
    late RetryDataSource dataSource;

    setUp(() {
      client = MockHttpClient();
      dataSource = RetryDataSource(client);
    });

    test('makes request with retry on failure', () async {
      when(() => client.get(any())).thenThrow(Exception());
      when(() => client.get(any())).thenAnswer((_) async => http.Response('OK', 200));

      final response = await dataSource.makeRequestWithRetry(Uri.parse('https://example.com'));

      expect(response.statusCode, 200);
    });
  });
}
