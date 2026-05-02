class VelocityMatrix {
  static const List<double> frameRates = [30, 60];
  static const List<double> velocities = [1.0, 2.0, 3.0, 4.0, 5.0];

  static Map<double, Map<double, double>> getMatrix() {
    final matrix = <double, Map<double, double>>{};
    for (var velocity in velocities) {
      matrix[velocity] = <double, double>{};
      for (var frameRate in frameRates) {
        matrix[velocity]?[frameRate] = calculateAnimationSpeed(velocity, frameRate);
      }
    }
    return matrix;
  }

  static double calculateAnimationSpeed(double velocity, double frameRate) {
    // Implement the logic to calculate the animation speed based on velocity and frame rate
    // For demonstration purposes, a simple formula is used
    return velocity * frameRate / 60;
  }
}
