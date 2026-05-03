import 'package:flutter/material.dart';
import 'package:game/utils/locale_keys.dart';
import 'package:intl/intl.dart';

void main() {
  final buffer = StringBuffer();
  final locale = Locale('pt', 'BR');
  final messages = LocaleKeys.instance.translationsFor(locale);

  messages.forEach((key, value) {
    if (key.startsWith('dica_')) {
      buffer.write('$key|$value\n');
    }
  });

  print(buffer.toString());
}
