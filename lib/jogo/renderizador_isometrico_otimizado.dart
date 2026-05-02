import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

class RenderizadorIsometricoOtimizacao extends RenderizadorIsometrico {
  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(0, 0);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.transparent,
    );
    super.render(canvas);
    canvas.restore();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: super.build(context),
    );
  }
}
