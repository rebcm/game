import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/i18n/i18n_service.dart';
import 'package:rebcm/i18n/locale.dart';
import 'package:rebcm/jogo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => I18nService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative Construction',
      localizationsDelegates: [
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }
        return supportedLocales.first;
      },
      home: Jogo(),
    );
  }
}
import 'package:provider/provider.dart';
import 'package:rebcm/persistencia/gerenciador_persistencia.dart';
import 'package:rebcm/jogo/inicializador_jogo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GerenciadorPersistencia()),
      ],
      child: InicializadorJogo(
        child: MyApp(),
      ),
    ),
  );
}
