import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/ui/gerenciador_excecoes.dart';
import 'package:rebcm/ui/tela_erro.dart';

void main() {
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GerenciadorAudio()),
    ],
    child: MyApp(),
  )
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GerenciadorExcecoes()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: Scaffold(
        body: Stack(
          children: [
            RenderizadorIsometrico(),
            TelaErro(),
          ],
        ),
      ),
    );
  }
}
