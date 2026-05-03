import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/features/dicas/contexto_dicas.dart';

class DicaModal extends StatelessWidget {
  final String titulo;
  final String mensagem;

  DicaModal({required this.titulo, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContextoDicas>(
      builder: (context, contextoDicas, child) {
        return ElevatedButton(
          onPressed: () {
            contextoDicas.mostrarDicaModal(context, titulo, mensagem);
          },
          child: Text('Mostrar Dica'),
        );
      },
    );
  }
}
