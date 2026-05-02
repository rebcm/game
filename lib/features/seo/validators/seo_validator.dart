import 'package:passdriver/features/seo/models/seo_metadata.dart';

class SeoValidator {
  static bool validateDescription(String description) {
    return description.length >= 150 && description.length <= 255;
  }

  static bool validateKeywords(List<String> keywords, List<String> requiredKeywords) {
    return requiredKeywords.every((keyword) => keywords.contains(keyword));
  }

  static bool validateSeoMetadata(SeoMetadata metadata, List<String> requiredKeywords) {
    return validateDescription(metadata.description) && validateKeywords(metadata.keywords, requiredKeywords);
  }
}
