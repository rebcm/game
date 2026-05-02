import 'dart:math';

class Camera3DUtils {
  static double calculateRotation(double currentRotation, double delta) {
    return currentRotation + delta;
  }
}
