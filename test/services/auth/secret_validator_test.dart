import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/auth/secret_validator.dart';

void main() {
  group('SecretValidator', () {
    test('should return false for null secret', () {
      expect(SecretValidator.isValid(null), false);
    });

    test('should return false for empty secret', () {
      expect(SecretValidator.isValid(''), false);
    });

    test('should return false for secret without prefix', () {
      expect(SecretValidator.isValid('invalid_prefix_1234567890'), false);
    });

    test('should return false for secret with prefix but too short', () {
      expect(SecretValidator.isValid('reb_short'), false);
    });

    test('should return true for valid secret', () {
      expect(SecretValidator.isValid('reb_1234567890abcdef'), true);
    });
  });
}
