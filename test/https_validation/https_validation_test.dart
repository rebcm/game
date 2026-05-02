import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  test('HTTPS validation test', () async {
    final url = Uri.parse('https://example.com/preview');
    final response = await http.head(url);
    expect(response.statusCode, 200);
  });
}
