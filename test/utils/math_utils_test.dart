import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/math_utils.dart';

void main() {
  test('areAlmostEqual returns true for almost equal numbers', () {
    expect(MathUtils.areAlmostEqual(0.0001, 0.0002, 0.0001), true);
  });

  test('areAlmostEqual returns false for not almost equal numbers', () {
    expect(MathUtils.areAlmostEqual(0.0001, 0.0003, 0.0001), false);
  });
}
