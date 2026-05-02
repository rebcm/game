import 'package:flutter/material.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate {
  @override
  bool isSupported(Locale locale) => ['pt', 'en'].contains(locale.languageCode);

  @override
  Future load(Locale locale) async {
    // Loading is handled by I18nService
    return SynchronousFuture(null);
  }

  @override
  bool shouldReload(_) => false;
}
