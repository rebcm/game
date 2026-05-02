import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const _localizedValues = {
    'en': {
      'game_title': 'Rebeca\'s Creative World',
      'block_placed': 'Block placed',
      'block_removed': 'Block removed',
    },
    'pt': {
      'game_title': 'Mundo Criativo da Rebeca',
      'block_placed': 'Bloco colocado',
      'block_removed': 'Bloco removido',
    },
  };

  String get gameTitle => _localizedValues[locale.languageCode]['game_title'];
  String get blockPlaced => _localizedValues[locale.languageCode]['block_placed'];
  String get blockRemoved => _localizedValues[locale.languageCode]['block_removed'];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
