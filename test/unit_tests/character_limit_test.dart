import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/input_validator.dart';

void main() {
  group('Character Limit Tests', () {
    test('should accept input within character limit', () {
      final result = InputValidator.validateInput('valid_input');
      expect(result, isTrue);
    });

    test('should reject input exceeding character limit', () {
      final result = InputValidator.validateInput('a' * 256);
      expect(result, isFalse);
    });
  });
}
