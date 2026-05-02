import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/seo_metadata_validation/models/seo_metadata.dart';
import 'package:passdriver/features/seo_metadata_validation/validators/seo_metadata_validator.dart';

void main() {
  group('SeoMetadataValidator', () {
    test('isValidDescription should return true for valid descriptions', () {
      expect(SeoMetadataValidator.isValidDescription('A valid description that contains ride or hail'), true);
    });

    test('isValidDescription should return false for invalid descriptions', () {
      expect(SeoMetadataValidator.isValidDescription('Too short'), false);
    });

    test('areValidKeywords should return true for valid keywords', () {
      final requiredKeywords = SeoMetadataValidator.getRequiredKeywords();
      expect(SeoMetadataValidator.areValidKeywords([...requiredKeywords, 'extra keyword'], requiredKeywords), true);
    });

    test('areValidKeywords should return false for invalid keywords', () {
      final requiredKeywords = SeoMetadataValidator.getRequiredKeywords();
      expect(SeoMetadataValidator.areValidKeywords(['invalid keyword'], requiredKeywords), false);
    });

    test('isValidSeoMetadata should return true for valid SEO metadata', () {
      final validSeoMetadata = SeoMetadata(description: 'A valid description', keywords: SeoMetadataValidator.getRequiredKeywords());
      expect(SeoMetadataValidator.isValidSeoMetadata(validSeoMetadata), true);
    });

    test('isValidSeoMetadata should return false for invalid SEO metadata', () {
      final invalidSeoMetadata = SeoMetadata(description: 'Too short', keywords: []);
      expect(SeoMetadataValidator.isValidSeoMetadata(invalidSeoMetadata), false);
    });
  });
}
