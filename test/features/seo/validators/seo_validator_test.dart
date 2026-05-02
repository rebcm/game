import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/seo/models/seo_metadata.dart';
import 'package:passdriver/features/seo/validators/seo_validator.dart';

void main() {
  group('SeoValidator', () {
    test('validateDescription returns true for valid description', () {
      expect(SeoValidator.validateDescription('a' * 150), true);
    });

    test('validateDescription returns false for description that is too short', () {
      expect(SeoValidator.validateDescription('a' * 149), false);
    });

    test('validateDescription returns false for description that is too long', () {
      expect(SeoValidator.validateDescription('a' * 256), false);
    });

    test('validateKeywords returns true when all required keywords are present', () {
      expect(SeoValidator.validateKeywords(['PassDriver', 'ride-hailing', 'Brazil'], ['PassDriver', 'ride-hailing']), true);
    });

    test('validateKeywords returns false when a required keyword is missing', () {
      expect(SeoValidator.validateKeywords(['PassDriver'], ['PassDriver', 'ride-hailing']), false);
    });

    test('validateSeoMetadata returns true for valid metadata', () {
      final metadata = SeoMetadata(description: 'a' * 150, keywords: ['PassDriver', 'ride-hailing', 'Brazil']);
      expect(SeoValidator.validateSeoMetadata(metadata, ['PassDriver', 'ride-hailing']), true);
    });

    test('validateSeoMetadata returns false for invalid metadata', () {
      final metadata = SeoMetadata(description: 'a' * 149, keywords: ['PassDriver']);
      expect(SeoValidator.validateSeoMetadata(metadata, ['PassDriver', 'ride-hailing']), false);
    });
  });
}
