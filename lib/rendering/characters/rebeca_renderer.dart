import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/models/characters/rebeca.dart';

class RebecaRenderer extends SpriteComponent with HasGameRef {
  final Rebeca rebeca;

  RebecaRenderer({required this.rebeca});

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load(rebeca.skinPath);
    this.sprite = sprite;
    size = Vector2(1.0, 2.0); // Ajuste conforme necessário
  }
}
