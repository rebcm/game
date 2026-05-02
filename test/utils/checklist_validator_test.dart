import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/checklist_validator.dart';

void main() {
  group('ChecklistValidator', () {
    test('validateTitle', () {
      expect(ChecklistValidator.validateTitle('a' * 72), true);
      expect(ChecklistValidator.validateTitle('a' * 73), false);
    });

    test('validateDescription', () {
      expect(ChecklistValidator.validateDescription('a' * 150), true);
      expect(ChecklistValidator.validateDescription('a' * 151), false);
    });

    test('validateLink', () {
      expect(ChecklistValidator.validateLink('https://example.com'), true);
      expect(ChecklistValidator.validateLink(''), false);
    });
  });
}
