import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/animation_speed_control/providers/speed_matrix_provider.dart';

void main() {
  test('loads speed matrix correctly', () {
    final provider = SpeedMatrixProvider();
    provider.loadSpeedMatrix();
    expect(provider.speedMatrix.length, 5);
  });
}
