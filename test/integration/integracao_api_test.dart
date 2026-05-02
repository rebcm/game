// Sample test file, adjust according to your needs
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('API call test', () async {
    final response = await http.get(Uri.parse('https://staging-api.example.com'));
    expect(response.statusCode, 200);
  });
}
