import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TraducaoService with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void mudarIdioma(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  String traduzir(String chave) {
    return Intl.message(chave, name: chave);
  }
}
