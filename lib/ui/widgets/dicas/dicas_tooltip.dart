import 'package:flutter/material.dart';

class DicasTooltip extends StatelessWidget {
  final String dica;

  const DicasTooltip({Key? key, required this.dica}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: dica,
      child: const Icon(Icons.help_outline),
    );
  }
}
