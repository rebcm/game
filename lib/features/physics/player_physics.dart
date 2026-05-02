import 'package:flame/components.dart';
import 'package:rebcm/features/physics/physics_component.dart';

class PlayerPhysics extends PhysicsComponent {
  double gravity = 9.8;
  double velocityY = 0;
  bool isOnGround = false;

  @override
  void update(double dt) {
    super.update(dt);
    updatePhysics(dt);
    applyGravity(dt);
    checkCollision();
  }

  void applyGravity(double dt) {
    if (!isOnGround) {
      velocityY += gravity * dt;
    }
  }

  void checkCollision() {
    // Implement collision detection logic here
  }

  void jump() {
    if (isOnGround) {
      velocityY = -10; // Adjust jump velocity as needed
      isOnGround = false;
    }
  }
}
