import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class Rebeca extends PositionComponent {
  late Sprite _sprite;
  late SpriteAnimation _idleAnimation;
  late SpriteAnimation _walkAnimation;
  late SpriteAnimation _runAnimation;
  late SpriteAnimation _jumpAnimation;
  late SpriteAnimation _flyAnimation;
  late SpriteAnimation _placeBlockAnimation;
  late SpriteAnimation _breakBlockAnimation;

  Rebeca() : super(priority: 1) {
    _loadSprite();
    _loadAnimations();
  }

  Future<void> _loadSprite() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('characters/rebeca_skin.png'),
      srcSize: Vector2(64, 64),
    );
    _sprite = spriteSheet.getSprite(0, 0);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('characters/rebeca_skin.png'),
      srcSize: Vector2(64, 64),
    );

    _idleAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      frames: [0, 1, 2, 3],
    );

    _walkAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: 0.1,
      frames: [0, 1, 2, 3],
    );

    _runAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: 0.1,
      frames: [0, 1, 2, 3],
    );

    _jumpAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: 0.1,
      frames: [0],
    );

    _flyAnimation = spriteSheet.createAnimation(
      row: 4,
      stepTime: 0.1,
      frames: [0, 1],
    );

    _placeBlockAnimation = spriteSheet.createAnimation(
      row: 5,
      stepTime: 0.1,
      frames: [0, 1, 2],
    );

    _breakBlockAnimation = spriteSheet.createAnimation(
      row: 6,
      stepTime: 0.1,
      frames: [0, 1, 2],
    );
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: Vector2(100, 100));
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void idle() {
    // Implement idle animation logic
  }

  void walk() {
    // Implement walk animation logic
  }

  void run() {
    // Implement run animation logic
  }

  void jump() {
    // Implement jump animation logic
  }

  void fly() {
    // Implement fly animation logic
  }

  void placeBlock() {
    // Implement place block animation logic
  }

  void breakBlock() {
    // Implement break block animation logic
  }
}
