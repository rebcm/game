import 'package:flutter/material.dart';
import 'package:game/features/dicas/contexto/contexto_dicas.dart';

class IntegracaoDicas extends StatelessWidget {
  final String telaAtual;

  const IntegracaoDicas({Key? key, required this.telaAtual}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextoDicas(telaAtual: telaAtual);
  }
}
