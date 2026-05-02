import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/personagem/rebeca.dart';

class RebecaController extends Component with HasGameRef {
  late Rebeca _rebeca;

  @override
  Future<void> onLoad() async {
    _rebeca = Rebeca();
    gameRef.add(_rebeca);
  }

  void handleInput() {
    // Implement input handling logic for Rebeca
  }
}
