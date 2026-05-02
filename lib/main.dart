import 'package:flutter/material.dart';
import 'package:rebcm/widgets/informacoes_personagem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: InformacoesPersonagem(),
      ),
    );
  }
}
