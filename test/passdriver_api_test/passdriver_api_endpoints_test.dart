import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/passdriver_api.dart';

void main() {
  group('PassDriver API Endpoints', () {
    test('GET /users', () async {
      final response = await http.get(Uri.parse('https://api.passdriver.com/users'));
      expect(response.statusCode, 200);
    });

    test('POST /users', () async {
      final response = await http.post(Uri.parse('https://api.passdriver.com/users'), body: {'name': 'Rebeca', 'email': 'rebeca@example.com'});
      expect(response.statusCode, 201);
    });

    test('GET /users/:id', () async {
      final response = await http.get(Uri.parse('https://api.passdriver.com/users/1'));
      expect(response.statusCode, 200);
    });

    test('PUT /users/:id', () async {
      final response = await http.put(Uri.parse('https://api.passdriver.com/users/1'), body: {'name': 'Rebeca Alves', 'email': 'rebeca.alves@example.com'});
      expect(response.statusCode, 200);
    });

    test('DELETE /users/:id', () async {
      final response = await http.delete(Uri.parse('https://api.passdriver.com/users/1'));
      expect(response.statusCode, 204);
    });
  });
}
