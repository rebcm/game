import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('Swagger tests', () {
    test('Validate Swagger YAML', () async {
      final response = await http.get(Uri.parse('http://localhost:8080/swagger.yaml'));
      expect(response.statusCode, 200);
    });
  });
}
