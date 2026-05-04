/// Constants related to numerical precision.
class Epsilon {
  /// Default epsilon value used for floating-point comparisons.
  static const double defaultEpsilon = 0.0001;

  /// Prevent instantiation of this utility class.
  const Epsilon._();

  /// Compares two double values for equality within the default epsilon.
  static bool areEqual(double a, double b) => (a - b).abs() <= defaultEpsilon;
}
