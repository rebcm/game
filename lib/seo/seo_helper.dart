class SeoHelper {
  static const List<String> keywords = [
    'Flutter',
    'PassDriver',
    'Creative mode',
    'Voxel blocks',
  ];

  static bool containsKeyword(String text) {
    return keywords.any((keyword) => text.toLowerCase().contains(keyword.toLowerCase()));
  }
}
