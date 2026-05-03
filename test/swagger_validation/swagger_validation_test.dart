import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
    test('GET /api/v1/blocks', () async {
        final response = await http.get(Uri.parse('http://localhost:8080/api/v1/blocks'));
        expect(response.statusCode, 200);
    });

    test('POST /api/v1/blocks', () async {
        final response = await http.post(Uri.parse('http://localhost:8080/api/v1/blocks'));
        expect(response.statusCode, 201);
    });

    test('GET /api/v1/blocks/{id}', () async {
        final response = await http.get(Uri.parse('http://localhost:8080/api/v1/blocks/1'));
        expect(response.statusCode, 200);
    });

    test('PUT /api/v1/blocks/{id}', () async {
        final response = await http.put(Uri.parse('http://localhost:8080/api/v1/blocks/1'));
        expect(response.statusCode, 200);
    });

    test('DELETE /api/v1/blocks/{id}', () async {
        final response = await http.delete(Uri.parse('http://localhost:8080/api/v1/blocks/1'));
        expect(response.statusCode, 204);
    });
}
