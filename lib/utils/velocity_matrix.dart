class VelocityMatrix {
  static const List<double> velocities = [1.0, 2.0, 3.0, 4.0, 5.0];
  static const List<int> frameRates = [30, 60, 120];

  static double getAnimationSpeed(double velocity, int frameRate) {
    // Implement the logic to calculate the animation speed based on velocity and frame rate
    // For example:
    return velocity * frameRate / 60;
  }

  static Map<String, double> generateMatrix() {
    Map<String, double> matrix = {};
    for (double velocity in velocities) {
      for (int fps in frameRates) {
        double animationSpeed = getAnimationSpeed(velocity, fps);
        matrix['$velocity-$fps'] = animationSpeed;
      }
    }
    return matrix;
  }
}
