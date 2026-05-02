import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/i18n/i18n_service.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    I18nService().init(locale);
    notifyListeners();
  }
}
