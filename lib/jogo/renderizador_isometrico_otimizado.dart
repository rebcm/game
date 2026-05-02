import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

class RenderizadorIsometricoOtimizacao extends RenderizadorIsometrico {
  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(0, 0);
    // Adicionar RepaintBoundary
    canvas.saveLayer(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..isAntiAlias = true,
    );
    super.render(canvas);
    canvas.restore();
    canvas.restore();
  }
}
