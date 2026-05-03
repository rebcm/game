import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/input_normalizer.dart';

void main() {
  group('InputNormalizer', () {
    late InputNormalizer normalizer;

    setUp(() {
      normalizer = InputNormalizer(
        deadzoneThreshold: 0.2,
        maxSpeed: 10.0,
      );
    });

    test('should return 0 when input is within deadzone', () {
      expect(normalizer.normalizeInput(0.1, 0.01), 0.0);
    });

    test('should normalize input outside deadzone', () {
      expect(normalizer.normalizeInput(1.0, 0.01), isNonZero);
    });

    test('should smoothly transition between inputs', () {
      normalizer.normalizeInput(1.0, 0.01);
      expect(normalizer.normalizeInput(-1.0, 0.1), isNot(-10.0));
    });
  });
}
