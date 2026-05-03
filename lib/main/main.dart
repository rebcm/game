import 'package:flutter/material.dart';
import 'package:game/features/dicas/integracao/integracao_dicas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IntegracaoDicas(telaAtual: 'TelaInicial'),
      ),
    );
  }
}
