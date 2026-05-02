import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rebcm/i18n/i18n_service.dart';
import 'package:rebcm/jogo.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Construção Criativa',
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      home: Jogo(),
    ),
  );
}
