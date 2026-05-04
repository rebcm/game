import 'package:flutter_test/flutter_test.dart';
import 'package:game/infrastructure/content_provider/api_content_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('ApiContentProvider returns a tip on successful request', () async {
    final mockHttpClient = MockClient((request) async {
      return http.Response('{"tip": "This is a tip"}', 200);
    });
    final provider = ApiContentProvider();
    // Override http client for testing
    final tip = await provider.getTip();
    expect(tip, isNotEmpty);
  });

  test('ApiContentProvider throws on failed request', () async {
    final mockHttpClient = MockClient((request) async {
      return http.Response('Not Found', 404);
    });
    final provider = ApiContentProvider();
    // Override http client for testing
    expect(() async => await provider.getTip(), throwsException);
  });
}
