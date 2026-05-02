import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/animation/rebeca_animation.dart';

void main() {
  group('RebecaAnimation', () {
    test('should animate correctly', () {
      final animation = RebecaAnimation();
      expect(animation.isAnimating, isFalse);
      animation.start();
      expect(animation.isAnimating, isTrue);
      animation.stop();
      expect(animation.isAnimating, isFalse);
    });
  });
}
