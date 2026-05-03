import 'package:test/test.dart';
import 'dart:convert';
import 'package:game/docs/bloco_documentation/block_reference_extractor.dart';

void main() {
  test('extractBlockReference returns valid JSON', () async {
    final result = await extractBlockReference();
    expect(result, isA<Map<String, dynamic>>());
    expect(result['blocks'], isA<List>());
    final jsonString = jsonEncode(result);
    expect(jsonDecode(jsonString)['blocks'], isA<List>());
  });
}
