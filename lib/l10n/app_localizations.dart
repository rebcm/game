import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:game/l10n/app_localizations_de.dart';
import 'package:game/l10n/app_localizations_fr.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'de': AppLocalizationsDe(),
    'fr': AppLocalizationsFr(),
  };

  String getText(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? '';
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => ['de', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
