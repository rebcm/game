import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/input/input_normalizer.dart';

void main() {
  group('InputNormalizer', () {
    test('normalizes input correctly', () {
      final normalizer = InputNormalizer(deadzone: 0.2);
      expect(normalizer.normalize(0.1), 0);
      expect(normalizer.normalize(0.3), closeTo(0.125, 0.01));
    });
  });
}
