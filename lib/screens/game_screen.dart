import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/rendering/characters/rebeca_renderer.dart';
import 'package:rebcm/models/characters/rebeca.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Game(
      game: _Game(),
    );
  }
}

class _Game extends FlameGame {
  late RebecaRenderer rebecaRenderer;

  @override
  Future<void> onLoad() async {
    rebecaRenderer = RebecaRenderer(rebeca: Rebeca.instance);
    add(rebecaRenderer);
  }
}
