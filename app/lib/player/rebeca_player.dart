import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/game.dart';

class RebecaPlayer extends PositionComponent with Velocity {
  RebecaPlayer() : super(priority: 1);

  late Sprite _sprite;

  @override
  Future<void> onLoad() async {
    _sprite = await Sprite.load('characters/rebeca_skin.png');
    size = Vector2(1, 2); // Adjust size as needed
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, position: position, size: size);
  }

  void update(double dt) {
    // Update player position and animations
  }

  void move(Vector2 direction) {
    // Implement movement logic
  }

  void jump() {
    // Implement jump logic
  }

  void fly() {
    // Implement fly logic
  }

  void interact() {
    // Implement interaction logic (e.g., break/place blocks)
  }
}
