import 'package:flutter/material.dart';
import 'package:passdriver/features/seo/models/seo_metadata.dart';
import 'package:passdriver/features/seo/validators/seo_validator.dart';

class SeoProvider with ChangeNotifier {
  List<String> _requiredKeywords = ['PassDriver', 'ride-hailing', 'Brazil'];

  List<String> get requiredKeywords => _requiredKeywords;

  bool validateSeoMetadata(SeoMetadata metadata) {
    return SeoValidator.validateSeoMetadata(metadata, _requiredKeywords);
  }
}
