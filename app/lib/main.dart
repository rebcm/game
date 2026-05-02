import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/core/game_loop.dart';

void main() {
  runApp(
    GameWidget(
      game: GameLoop(),
    ),
  );
}
