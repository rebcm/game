import 'package:flutter/material.dart';
import 'package:rebcm/jogo/animacao_personagem.dart';
import 'package:rebcm/personagem/rebeca.dart';

class HUD extends StatelessWidget {
  final Rebeca rebeca;

  const HUD({Key? key, required this.rebeca}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: AnimacaoPersonagem(rebeca: rebeca),
        ),
      ],
    );
  }
}
