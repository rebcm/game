import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/ui/gerenciador_excecoes.dart';

class TelaErro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gerenciadorExcecoes = context.watch<GerenciadorExcecoes>();

    if (gerenciadorExcecoes.mensagemErro == null) {
      return Container();
    }

    return Container(
      color: Colors.red.withOpacity(0.8),
      child: Center(
        child: Text(
          gerenciadorExcecoes.mensagemErro!,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
