import 'package:game/constants/epsilon.dart';

/// Utility functions for mathematical operations.
class MathUtils {
  /// Checks if two double values are nearly equal.
  static bool nearlyEqual(double a, double b) => Epsilon.areEqual(a, b);

  /// Prevent instantiation of this utility class.
  const MathUtils._();
}
