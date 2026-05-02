import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/game.dart';

void main() {
  runApp(
    MaterialApp(
      home: GameWidget(
        game: MyGame(),
      ),
    ),
  );
}
