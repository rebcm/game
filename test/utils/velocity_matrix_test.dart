import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/velocity_matrix.dart';

void main() {
  group('VelocityMatrix', () {
    test('generateMatrix returns correct matrix', () {
      final matrix = VelocityMatrix.generateMatrix();
      expect(matrix, isNotEmpty);
      // Add more expectations based on the expected output
    });

    test('getAnimationSpeed calculates correctly', () {
      expect(VelocityMatrix.getAnimationSpeed(1.0, 60), 1.0);
      // Add more test cases
    });
  });
}
