import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/networking/http_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient _client;
  late CustomHttpClient _customHttpClient;

  setUp(() {
    _client = MockHttpClient();
    _customHttpClient = CustomHttpClient(_client);
  });

  test('get request includes Accept-Encoding header', () async {
    when(() => _client.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('{}', 200));
    await _customHttpClient.get(Uri.parse('https://example.com'));
    verify(() => _client.get(any(), headers: {'Accept-Encoding': 'gzip'})).called(1);
  });

  test('post request includes Content-Encoding and Accept-Encoding headers', () async {
    when(() => _client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('{}', 200));
    await _customHttpClient.post(Uri.parse('https://example.com'));
    verify(() => _client.post(any(), headers: {'Content-Encoding': 'gzip', 'Accept-Encoding': 'gzip'}, body: null)).called(1);
  });
}
