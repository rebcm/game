import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:game/l10n/l10n.dart';

class TranslationService {
  static Future<void> init() async {
    await Intl.defaultLocale;
  }

  static String? getLocale() {
    return Intl.getCurrentLocale();
  }

  static String helloWorld() {
    return AppLocalizations.of(Locale(Intl.getCurrentLocale() ?? 'en'))!.helloWorld;
  }
}
