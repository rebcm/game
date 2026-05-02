import 'package:passdriver/features/seo_metadata_validation/models/seo_metadata.dart';

class SeoMetadataValidator {
  static const List<String> requiredKeywords = ['PassDriver', 'ride-hailing', 'Brazil'];

  bool validateDescription(String description) {
    return description.length >= 150 && description.length <= 255;
  }

  bool validateKeywords(List<String> keywords) {
    return requiredKeywords.every((keyword) => keywords.contains(keyword));
  }

  bool validateSeoMetadata(SeoMetadata seoMetadata) {
    return validateDescription(seoMetadata.description) && validateKeywords(seoMetadata.keywords);
  }
}
