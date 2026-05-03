import 'package:test/test.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  test('Validate bloco documentation', () async {
    final jsonData = await File('./docs/bloco_documentation.json').readAsString();
    final jsonMap = jsonDecode(jsonData);
    // Implement JSON schema validation logic here
    expect(jsonMap, isA<Map<String, dynamic>>());
  });
}
