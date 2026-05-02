import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/features/player.dart';

class MyGame extends FlameGame {
  late Player _player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _player = Player();
    add(_player);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void onTap() {
    _player.jump();
  }
}
