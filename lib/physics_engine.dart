class PhysicsEngine {
  bool checkCollision(Vector3 position) {
    // implementation of collision detection
    // for demonstration purposes, assume collision if x is within 0 to 16
    return position.x >= 0 && position.x <= 16;
  }
}

class Vector3 {
  double x, y, z;
  Vector3(this.x, this.y, this.z);
}
