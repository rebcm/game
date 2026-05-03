import 'package:flutter/material.dart';

class DicasTooltip extends StatelessWidget {
  final String mensagem;

  const DicasTooltip({Key? key, required this.mensagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: mensagem,
      child: Icon(Icons.help_outline),
    );
  }
}
