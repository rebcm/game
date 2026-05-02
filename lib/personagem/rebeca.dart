import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Rebeca extends SpriteComponent {
  Rebeca() : super(priority: 1);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('characters/rebeca.png');
    size = Vector2(64, 64); // Adjust size according to your game requirements
  }
}
