import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/networking/http_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient _mockClient;
  late CustomHttpClient _customHttpClient;

  setUp(() {
    _mockClient = MockHttpClient();
    _customHttpClient = CustomHttpClient(_mockClient);
  });

  group('CustomHttpClient', () {
    test('get request includes Accept-Encoding header', () async {
      when(() => _mockClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('{}', 200));
      await _customHttpClient.get(Uri.parse('https://example.com'));
      verify(() => _mockClient.get(any(), headers: {'Accept-Encoding': 'gzip'})).called(1);
    });

    test('post request includes Content-Encoding and Accept-Encoding headers', () async {
      when(() => _mockClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('{}', 200));
      await _customHttpClient.post(Uri.parse('https://example.com'));
      verify(() => _mockClient.post(any(), headers: {'Content-Encoding': 'gzip', 'Accept-Encoding': 'gzip'}, body: null)).called(1);
    });
  });
}
