import 'package:passdriver/features/seo_metadata_validation/models/seo_metadata.dart';

class SeoMetadataValidator {
  static bool isValidDescription(String description) {
    // Implement description validation logic here
    // For example, checking if it contains certain keywords or has a minimum length
    return description.length > 50 && description.contains(RegExp(r'\b(ride|hail|transport)\b'));
  }

  static bool areValidKeywords(List<String> keywords, List<String> requiredKeywords) {
    return requiredKeywords.every((keyword) => keywords.contains(keyword));
  }

  static List<String> getRequiredKeywords() {
    // Define the list of required keywords for SEO
    return ['PassDriver', 'ride hailing', 'Brazil'];
  }

  static bool isValidSeoMetadata(SeoMetadata seoMetadata) {
    final requiredKeywords = getRequiredKeywords();
    return isValidDescription(seoMetadata.description) && areValidKeywords(seoMetadata.keywords, requiredKeywords);
  }
}
