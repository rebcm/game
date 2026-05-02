import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Localizacao {
  static late Locale locale;

  static void configurar(Locale locale) {
    Localizacao.locale = locale;
    Intl.defaultLocale = locale.toString();
  }

  static String tr(String chave) {
    return Intl.message(
      chave,
      name: chave,
      locale: locale.toString(),
    );
  }
}
