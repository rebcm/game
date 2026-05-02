import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/lighting/soft_shadows.dart';

void main() {
  group('SoftShadows', () {
    test('initial intensity is correct', () {
      final softShadows = SoftShadows();
      expect(softShadows._intensity, 0.5);
    });
  });
}
