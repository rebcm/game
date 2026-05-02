import 'package:flutter/material.dart';
import 'package:passdriver/features/i18n/validations/description_translation_validator.dart';

class DescriptionTranslationProvider with ChangeNotifier {
  final DescriptionTranslationValidator _validator;

  DescriptionTranslationProvider(this._validator);

  bool validateDescriptionTranslation(String originalDescription, String translatedDescription) {
    return _validator.validate(originalDescription, translatedDescription);
  }
}
