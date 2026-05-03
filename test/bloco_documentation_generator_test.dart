import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/bloco_documentation_generator.dart';

void main() {
  test('should generate bloco documentation json', () {
    final jsonData = BlocoDocumentationGenerator.generate();
    expect(jsonData, isA<String>());
    expect(jsonDecode(jsonData)['blocos'], isA<List>());
  });
}
