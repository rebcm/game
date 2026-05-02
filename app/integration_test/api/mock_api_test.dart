import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('Mock API Test', () async {
    final client = MockClient((request) async {
      return http.Response('{"message": "success"}', 200);
    });

    final response = await client.get(Uri.parse('https://construcao-criativa.workers.dev'));
    expect(response.statusCode, 200);
    expect(response.body, '{"message": "success"}');
  });
}
