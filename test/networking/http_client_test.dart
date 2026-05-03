import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/networking/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late CustomHttpClient customClient;

  setUp(() {
    client = MockHttpClient();
    customClient = CustomHttpClient(client);
  });

  test('get request includes Accept-Encoding header', () async {
    when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('{}', 200));
    await customClient.get(Uri.parse('https://example.com'));
    verify(() => client.get(any(), headers: {'Accept-Encoding': 'gzip'})).called(1);
  });

  test('post request includes Content-Encoding and Accept-Encoding headers', () async {
    when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('{}', 200));
    await customClient.post(Uri.parse('https://example.com'));
    verify(() => client.post(any(), headers: {'Content-Encoding': 'gzip', 'Accept-Encoding': 'gzip'}, body: null)).called(1);
  });
}
