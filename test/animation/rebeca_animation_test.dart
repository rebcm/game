import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/animation/rebeca_animation.dart';

void main() {
  group('RebecaAnimation', () {
    test('should animate correctly', () {
      final animation = RebecaAnimation();
      expect(animation.animate(), isNotNull);
    });

    test('should stop animation correctly', () {
      final animation = RebecaAnimation();
      animation.stop();
      expect(animation.isAnimating, isFalse);
    });
  });
}
