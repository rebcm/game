import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/game.dart';

class PhysicsComponent extends Component with HasGameRef<MyGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  void updatePhysics(double dt) {
    // Update physics logic here
  }
}
