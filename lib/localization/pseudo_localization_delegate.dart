import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PseudoLocalizationDelegate extends LocalizationsDelegate {
  @override
  bool isSupported(Locale locale) => locale.toString() == 'pseudo';

  @override
  Future load(Locale locale) async {
    // Load pseudo-localized strings
    Intl.message('Hello', name: 'Hello', desc: 'Hello message');
  }

  @override
  bool shouldReload(_) => false;
}
