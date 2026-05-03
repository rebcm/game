import 'package:flutter_test/flutter_test.dart';
import 'package:game/dicas/dicas.dart';

void main() {
  group('Dicas Test', () {
    test('should wrap text correctly with long strings', () {
      final longString = 'a' * 1000;
      final wrappedText = Dicas.wrapText(longString);
      expect(wrappedText, isNot(contains(longString)));
    });

    test('should handle different languages', () {
      final dicaPt = 'Dica em português';
      final dicaEn = 'Tip in English';
      expect(Dicas.wrapText(dicaPt), isNot(throwsException));
      expect(Dicas.wrapText(dicaEn), isNot(throwsException));
    });
  });
}
