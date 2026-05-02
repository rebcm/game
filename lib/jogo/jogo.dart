import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/jogo/renderizador_isometrico_otimizado.dart';

class Jogo extends FlameGame {
  late RenderizadorIsometricoOtimizacao _renderizador;

  @override
  Future<void> onLoad() async {
    _renderizador = RenderizadorIsometricoOtimizacao();
    // Initialize the renderer
  }

  @override
  Widget render(BuildContext context) {
    return _renderizador.build(context);
  }
}
