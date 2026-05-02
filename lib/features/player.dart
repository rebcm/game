import 'package:flame/components.dart';
import 'package:rebcm/features/physics/player_physics.dart';

class Player extends SpriteComponent with HasGameRef<MyGame> {
  late PlayerPhysics _physics;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _physics = PlayerPhysics();
    add(_physics);
  }

  void jump() {
    _physics.jump();
  }
}
