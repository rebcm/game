import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/mundo/gerador.dart';

class RenderizadorIsometrico extends FlameGame {
  late GeradorMundo _geradorMundo;

  @override
  Future<void> onLoad() async {
    _geradorMundo = GeradorMundo();
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Implementação da renderização isométrica
    // ...
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Sincronização com o loop de atualização do Flame
    // ...
  }
}
