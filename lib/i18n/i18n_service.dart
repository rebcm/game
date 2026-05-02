import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class I18nService {
  static final I18nService _instance = I18nService._();
  static I18nService get instance => _instance;
  I18nService._();

  Map<String, String> _localizedStrings = {};

  Future<void> loadLocale(String locale) async {
    final jsonString = await rootBundle.loadString('assets/translations/$locale.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) => _localizedStrings[key] ?? key;
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en_US': {
      'gameTitle': 'Creative Construction',
      'inventory': 'Inventory',
      'blockGrass': 'Grass',
    },
    'pt_BR': {
      'gameTitle': 'Construção Criativa',
      'inventory': 'Inventário',
      'blockGrass': 'Grama',
    },
  };

  String get gameTitle => _localizedValues[locale.toString()]?['gameTitle'] ?? 'gameTitle';
  String get inventory => _localizedValues[locale.toString()]?['inventory'] ?? 'inventory';
  String get blockGrass => _localizedValues[locale.toString()]?['blockGrass'] ?? 'blockGrass';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
