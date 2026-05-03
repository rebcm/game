import 'package:flutter/material.dart';
import 'package:game/services/dicas/dicas_service.dart';

class DicaWrapper extends StatelessWidget {
  final Widget child;

  const DicaWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  void mostrarDica(String mensagem) {
    DicasService().mostrarDica(context, mensagem);
  }
}
