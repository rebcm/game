import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/animation/rebeca_animation.dart';

void main() {
  group('RebecaAnimation', () {
    test('should animate correctly', () {
      final animation = RebecaAnimation();
      expect(animation.isAnimating, isFalse);
      animation.startAnimation();
      expect(animation.isAnimating, isTrue);
    });

    test('should stop animating correctly', () {
      final animation = RebecaAnimation();
      animation.startAnimation();
      expect(animation.isAnimating, isTrue);
      animation.stopAnimation();
      expect(animation.isAnimating, isFalse);
    });
  });
}
