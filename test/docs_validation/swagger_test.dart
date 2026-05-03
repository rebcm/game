import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('GET /api/v1/docs returns 200', () async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/v1/docs'));
    expect(response.statusCode, 200);
  });

  test('GET /api/v1/endpoints returns 200', () async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/v1/endpoints'));
    expect(response.statusCode, 200);
  });
}
