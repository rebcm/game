import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  test('Validate Swagger Integration', () async {
    final response = await http.get(Uri.parse('https://rebcm.github.io/game/swagger.json'));
    expect(response.statusCode, 200);

    final jsonData = jsonDecode(response.body);
    expect(jsonData['swagger'], isNotNull);
    expect(jsonData['info']['title'], 'Rebeca Game API');
  });

  test('Generate Flutter Client using OpenAPI Generator', () async {
    final result = await Process.run('openapi-generator', ['generate', '-i', 'https://rebcm.github.io/game/swagger.json', '-g', 'dart']);
    expect(result.exitCode, 0);
  });
}
