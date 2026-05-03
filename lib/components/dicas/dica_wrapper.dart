import 'package:flutter/material.dart';
import 'package:game/services/dicas/dicas_service.dart';

class DicaWrapper extends StatelessWidget {
  final Widget child;
  final String? dica;

  const DicaWrapper({Key? key, required this.child, this.dica}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: dica ?? '',
      child: child,
    );
  }
}
