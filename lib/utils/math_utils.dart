import 'package:game/constants/epsilon.dart';

class MathUtils {
  static bool areAlmostEqual(double a, double b, [double epsilon = Epsilon.defaultEpsilon]) {
    return (a - b).abs() <= epsilon;
  }
}
