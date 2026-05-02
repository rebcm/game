import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class I18nService {
  Locale? _locale;

  static final Map<String, Map<String, String>> _localizedValues = {};

  Future<void> loadLocale(BuildContext context, Locale locale) async {
    final String jsonString = await rootBundle.loadString('assets/i18n/${locale.toString()}.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedValues[locale.toString()] = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    _locale = locale;
  }

  String? getTranslation(String key) {
    return _localizedValues[_locale?.toString() ?? 'pt_BR']?[key];
  }

  static String translate(BuildContext context, String key) {
    final i18nService = Provider.of<I18nService>(context, listen: false);
    return i18nService.getTranslation(key) ?? key;
  }
}
