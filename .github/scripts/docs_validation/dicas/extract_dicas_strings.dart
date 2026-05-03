import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game/l10n/l10n.dart';
import 'package:game/docs/dicas/dicas.dart';

void main() {
  final locale = Locale('pt', 'BR');
  final l10n = L10n(locale);

  final dicas = Dicas(l10n);
  final strings = dicas.getDicasStrings();

  File('lib/docs/dicas/dicas_strings.txt')
      .writeAsStringSync(strings.join('\n'));
}
