import 'package:flutter_test/flutter_test.dart';
import 'package:game/docs/bloco_documentation.dart';
import 'dart:convert';

void main() {
  test('loadBlocoDocumentation returns valid JSON', () async {
    final jsonData = await loadBlocoDocumentation();
    final jsonObject = jsonDecode(jsonData);
    expect(jsonObject, isA<Map<String, dynamic>>());
    expect(jsonObject['blocos'], isA<List<dynamic>>());
  });
}
