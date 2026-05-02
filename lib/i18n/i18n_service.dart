import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class I18nService {
  static final I18nService _instance = I18nService._();
  factory I18nService() => _instance;
  I18nService._();

  static Locale? _locale;

  Locale? get locale => _locale;

  void init(Locale locale) {
    _locale = locale;
    Intl.defaultLocale = locale.toString();
  }

  String get gameTitle => Intl.message('Creative Construction', name: 'gameTitle');
  String get inventory => Intl.message('Inventory', name: 'inventory');
  String get block => Intl.message('Block', name: 'block');
}
