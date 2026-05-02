import 'package:flutter/foundation.dart';

class SeoValidator {
  static const List<String> _requiredKeywords = [
    'voxel',
    'rebeca',
    'criativo',
    'blocos',
    'game',
  ];

  static bool validateDescription(String description) {
    if (description.isEmpty) return false;

    final lowerCaseDescription = description.toLowerCase();
    for (final keyword in _requiredKeywords) {
      if (!lowerCaseDescription.contains(keyword)) return false;
    }

    return true;
  }
}
