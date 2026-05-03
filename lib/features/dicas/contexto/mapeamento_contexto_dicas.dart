import 'package:flutter/material.dart';

class MapeamentoContextoDicas {
  static const List<String> telasComDicas = [
    'TelaInicial',
    'TelaConstrucao',
  ];

  static bool deveMostrarDica(String telaAtual) {
    return telasComDicas.contains(telaAtual);
  }

  static Widget? obterDica(String telaAtual) {
    switch (telaAtual) {
      case 'TelaInicial':
        return Tooltip(
          message: 'Dica inicial',
          child: Icon(Icons.info),
        );
      case 'TelaConstrucao':
        return Modal(
          conteudo: 'Dica de construção',
        );
      default:
        return null;
    }
  }
}

class Modal extends StatelessWidget {
  final String conteudo;

  const Modal({Key? key, required this.conteudo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(conteudo),
    );
  }
}
