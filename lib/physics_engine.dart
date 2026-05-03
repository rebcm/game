class PhysicsEngine {
  bool checkCollision(double position) {
    // Simplified logic for demonstration purposes
    const chunkSize = 16.0;
    return position >= 0 && position < chunkSize;
  }
}
