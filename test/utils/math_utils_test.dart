import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/math_utils.dart';

void main() {
  group('MathUtils', () {
    test('nearlyEqual should return true for equal numbers', () {
      expect(MathUtils.nearlyEqual(1.0, 1.0), isTrue);
    });

    test('nearlyEqual should return true for numbers within epsilon', () {
      expect(MathUtils.nearlyEqual(1.0, 1.00001), isTrue);
    });

    test('nearlyEqual should return false for numbers outside epsilon', () {
      expect(MathUtils.nearlyEqual(1.0, 1.1), isFalse);
    });
  });
}
