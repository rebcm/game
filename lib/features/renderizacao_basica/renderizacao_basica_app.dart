import 'package:flutter/material.dart';
import 'package:passdriver/features/renderizacao_basica/renderizacao_basica_page.dart';

class RenderizacaoBasicaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renderização Básica',
      home: RenderizacaoBasicaPage(),
    );
  }
}
