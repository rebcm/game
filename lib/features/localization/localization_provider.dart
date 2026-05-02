import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LocalizationProvider with ChangeNotifier {
  String? _locale;

  String? get locale => _locale;

  void changeLocale(String locale) {
    _locale = locale;
    FlutterI18n.refresh(context, locale);
    notifyListeners();
  }
}
