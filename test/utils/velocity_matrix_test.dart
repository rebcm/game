import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/velocity_matrix.dart';

void main() {
  group('VelocityMatrix', () {
    test('getMatrix returns a map with correct structure', () {
      final matrix = VelocityMatrix.getMatrix();
      expect(matrix, isA<Map<double, Map<double, double>>>());
      for (var velocity in VelocityMatrix.velocities) {
        expect(matrix[velocity], isA<Map<double, double>>());
        for (var frameRate in VelocityMatrix.frameRates) {
          expect(matrix[velocity]?[frameRate], isA<double>());
        }
      }
    });

    test('calculateAnimationSpeed returns a valid value', () {
      final animationSpeed = VelocityMatrix.calculateAnimationSpeed(1.0, 60);
      expect(animationSpeed, isA<double>());
      expect(animationSpeed, greaterThan(0));
    });
  });
}
