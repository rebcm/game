import 'package:flutter/material.dart';
import 'package:rebcm/i18n/localizacao.dart';
import 'package:rebcm/jogo.dart';

void main() {
  runApp(
    MaterialApp(
      title: Mensagens.tituloJogo,
      locale: Locale('pt', 'BR'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      home: Jogo(),
    ),
  );
  Localizacao.configurar(Locale('pt', 'BR'));
}
