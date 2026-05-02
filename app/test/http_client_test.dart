import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:your_app/http_client/http_client.dart';

void main() {
  test('http client test', () async {
    final client = HttpClient.getClient();
    final response = await client.get(Uri.parse('https://example.com'));
    expect(response.statusCode, 200);
  });
}
