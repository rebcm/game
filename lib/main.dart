import 'package:flutter/material.dart';
import 'package:rebcm/excecoes/tratador_excecoes.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  FlutterError.onError = TratadorExcecoes.tratarExcecao;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: RenderizadorIsometrico(),
    );
  }
}
import 'package:rebcm/ui/scroll_behavior.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      // ... existing code
    );
  }
}
