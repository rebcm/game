import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/features/dicas/contexto_dicas.dart';

class DicaTooltip extends StatelessWidget {
  final String mensagem;

  DicaTooltip({required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContextoDicas>(
      builder: (context, contextoDicas, child) {
        return Tooltip(
          message: mensagem,
          child: IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              contextoDicas.mostrarDicaToolTip(context, mensagem);
            },
          ),
        );
      },
    );
  }
}
