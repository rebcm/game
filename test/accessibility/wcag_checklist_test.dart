import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/accessibility/wcag_checklist.dart';

void main() {
  group('WCAG Checklist Tests', () {
    test('Verifica se todos os critérios estão presentes', () {
      expect(WCAGChecklist.criteria.length, 5);
    });

    test('Verifica se a avaliação de acessibilidade retorna todos os critérios', () {
      final result = WCAGChecklist.evaluateAccessibility();
      expect(result.keys.length, WCAGChecklist.criteria.length);
    });

    test('Verifica se as verificações individuais de acessibilidade retornam boolean', () {
      expect(WCAGChecklist._checkContrast(), isA<bool>());
      expect(WCAGChecklist._checkFontSize(), isA<bool>());
      expect(WCAGChecklist._checkScreenReaderSupport(), isA<bool>());
      expect(WCAGChecklist._checkKeyboardNavigation(), isA<bool>());
      expect(WCAGChecklist._checkUserFeedback(), isA<bool>());
    });
  });
}
