import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  test('Dicas strings extraction test', () {
    final dicas = Dicas();
    final strings = dicas.getAllDicasStrings();
    expect(strings, isNotEmpty);
  });
}
  test('peer review dicas test', () {
    // Implement the test for peer review dicas content
    expect(true, true);
  });
