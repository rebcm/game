/// Constants used throughout the project for precision and epsilon values.
///
/// This file centralizes epsilon values to avoid magic numbers and ensure
/// consistency across the codebase.

class Epsilon {
  /// The default epsilon value used for floating-point comparisons.
  static const double defaultEpsilon = 0.0001;

  /// Epsilon value used specifically in collision detection algorithms.
  static const double collisionDetection = defaultEpsilon;
}
