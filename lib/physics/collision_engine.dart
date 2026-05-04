import 'package:game/constants/epsilon.dart';

class CollisionEngine {
  bool areAlmostEqual(double a, double b) {
    return (a - b).abs() <= Epsilon.defaultEpsilon;
  }

  // Other collision detection methods...
}
