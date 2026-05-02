import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/seo_metadata_validation/models/seo_metadata.dart';
import 'package:passdriver/features/seo_metadata_validation/validators/seo_metadata_validator.dart';

void main() {
  group('SeoMetadataValidator', () {
    late SeoMetadataValidator validator;

    setUp(() {
      validator = SeoMetadataValidator();
    });

    test('should validate description length', () {
      expect(validator.validateDescription('a' * 149), false);
      expect(validator.validateDescription('a' * 150), true);
      expect(validator.validateDescription('a' * 255), true);
      expect(validator.validateDescription('a' * 256), false);
    });

    test('should validate required keywords', () {
      expect(validator.validateKeywords(['PassDriver']), false);
      expect(validator.validateKeywords(SeoMetadataValidator.requiredKeywords), true);
    });

    test('should validate SeoMetadata', () {
      final validSeoMetadata = SeoMetadata(
        description: 'a' * 150,
        keywords: SeoMetadataValidator.requiredKeywords,
      );
      final invalidSeoMetadata = SeoMetadata(
        description: 'a' * 149,
        keywords: ['invalid'],
      );

      expect(validator.validateSeoMetadata(validSeoMetadata), true);
      expect(validator.validateSeoMetadata(invalidSeoMetadata), false);
    });
  });
}
