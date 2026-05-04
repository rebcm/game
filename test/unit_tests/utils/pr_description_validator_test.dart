import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/pr_description_validator.dart';

void main() {
  group('PRDescriptionValidator', () {
    test('should return false for empty description', () {
      expect(PRDescriptionValidator.validate(''), false);
    });

    test('should return true for non-empty description', () {
      expect(PRDescriptionValidator.validate('Valid description'), true);
    });
  });
}
