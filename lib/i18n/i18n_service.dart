import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class I18nService {
  static final I18nService _instance = I18nService._();
  static I18nService get instance => _instance;
  I18nService._();

  Map<String, String> _localizedStrings;

  Future<void> loadLocale(String locale) async {
    final jsonString = await rootBundle.loadString('assets/i18n/$locale.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
