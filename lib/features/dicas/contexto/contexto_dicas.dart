import 'package:flutter/material.dart';
import 'package:game/features/dicas/contexto/mapeamento_contexto_dicas.dart';

class ContextoDicas extends StatelessWidget {
  final String telaAtual;

  const ContextoDicas({Key? key, required this.telaAtual}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MapeamentoContextoDicas.deveMostrarDica(telaAtual)) {
      return MapeamentoContextoDicas.obterDica(telaAtual) ?? Container();
    }
    return Container();
  }
}
