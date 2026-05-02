import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/jogo/renderizador_isometrico_otimizado.dart';

class JogoWidgetOtimizacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GameWidget(
        game: RenderizadorIsometricoOtimizacao(),
      ),
    );
  }
}
