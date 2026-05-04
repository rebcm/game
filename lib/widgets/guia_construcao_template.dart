import 'package:flutter/material.dart';
import 'package:game/utils/guia_construcao.dart';

class GuiaConstrucaoTemplate extends StatelessWidget {
  final String material;
  final String tempoConstrucao;
  final String dificuldade;

  const GuiaConstrucaoTemplate({
    Key? key,
    required this.material,
    required this.tempoConstrucao,
    required this.dificuldade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${GuiaConstrucao.material(context)}: $material'),
        Text('${GuiaConstrucao.tempoConstrucao(context)}: $tempoConstrucao'),
        Text('${GuiaConstrucao.dificuldade(context)}: $dificuldade'),
      ],
    );
  }
}
