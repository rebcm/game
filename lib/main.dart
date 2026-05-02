import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/utils/traducao.dart';
import 'package:rebcm/jogo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TraducaoService()),
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
      locale: context.watch<TraducaoService>().locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('pt', ''),
      ],
      home: Jogo(),
    );
  }
}
