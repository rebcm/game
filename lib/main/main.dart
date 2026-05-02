import 'package:flutter/material.dart';
import 'package:rebcm/game/game.dart';

void main() {
  runApp(
    MaterialApp(
      home: GameWidget(
        game: RebecaGame(),
      ),
    ),
  );
}
