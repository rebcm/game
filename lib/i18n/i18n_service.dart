import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class I18nService {
  static final I18nService _instance = I18nService._internal();

  factory I18nService() => _instance;

  I18nService._internal();

  Locale? _locale;

  Future<void> init(Locale locale) async {
    _locale = locale;
  }

  String translate(String key) {
    if (_locale == null) return key;
    return _getTranslation(_locale!.languageCode)[key] ?? key;
  }

  Map<String, dynamic> _getTranslation(String languageCode) {
    switch (languageCode) {
      case 'en':
        return jsonDecode(_enJson);
      case 'pt':
        return jsonDecode(_ptJson);
      default:
        return {};
    }
  }

  static const String _enJson = '''
{
  "hello": "Hello",
  "world": "World"
}
''';

  static const String _ptJson = '''
{
  "hello": "Olá",
  "world": "Mundo"
}
''';
}
