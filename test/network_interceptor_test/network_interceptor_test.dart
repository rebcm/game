import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/network/network_interceptor.dart';

void main() {
  late http.Client client;
  late DioAdapter dioAdapter;
  late NetworkInterceptor interceptor;

  setUp(() {
    client = http.Client();
    dioAdapter = DioAdapter();
    interceptor = NetworkInterceptor(client);
  });

  tearDown(() {
    client.close();
  });

  test('should return 500 on client exception', () async {
    final uri = Uri.parse('https://example.com');
    dioAdapter.onGet(uri.toString(), (server) => http.Response('Not Found', 404));

    final response = await interceptor.get(uri);

    expect(response.statusCode, 500);
  });

  test('should return 500 on unknown exception', () async {
    final uri = Uri.parse('https://example.com');

    expect(() async => await interceptor.get(uri), throwsException);
  });

  test('should handle timeout', () async {
    final uri = Uri.parse('https://example.com');
    dioAdapter.onGet(uri.toString(), (server) async {
      await Future.delayed(Duration(seconds: 10));
      return http.Response('Timeout', 408);
    });

    final response = await interceptor.get(uri);

    expect(response.statusCode, 500);
  });

  test('should handle 5xx error', () async {
    final uri = Uri.parse('https://example.com');
    dioAdapter.onGet(uri.toString(), (server) => http.Response('Server Error', 503));

    final response = await interceptor.get(uri);

    expect(response.statusCode, 503);
  });
}
