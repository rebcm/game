import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/math_utils.dart';

void main() {
  group('MathUtils', () {
    test('areAlmostEqual returns true for numbers within epsilon', () {
      expect(MathUtils.areAlmostEqual(0.0001, 0.0002), isTrue);
    });

    test('areAlmostEqual returns false for numbers outside epsilon', () {
      expect(MathUtils.areAlmostEqual(0.0001, 0.1), isFalse);
    });

    test('areAlmostEqual uses custom epsilon when provided', () {
      expect(MathUtils.areAlmostEqual(0.0001, 0.0002, epsilon: 0.00005), isFalse);
    });
  });
}
