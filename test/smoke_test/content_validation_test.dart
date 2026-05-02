import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('validate content', () async {
    final response = await http.get(Uri.parse('https://example.com'));
    expect(response.statusCode, 200);
    expect(response.body, contains('passdriver'));
  });
}
