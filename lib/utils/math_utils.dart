import 'package:game/constants/epsilon.dart';

/// Utility functions for mathematical operations.
///
/// This class provides helper methods for comparing floating-point numbers.

class MathUtils {
  /// Compares two floating-point numbers for equality within a certain epsilon.
  static bool areAlmostEqual(double a, double b, {double epsilon = Epsilon.defaultEpsilon}) {
    return (a - b).abs() <= epsilon;
  }
}
