import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/input/input_normalizer.dart';

void main() {
  group('InputNormalizer', () {
    test('should return 0 when input is within deadzone', () {
      final normalizer = InputNormalizer(deadzone: 0.2);
      expect(normalizer.normalize(0.1), 0);
    });

    test('should normalize input outside deadzone', () {
      final normalizer = InputNormalizer(deadzone: 0.2);
      expect(normalizer.normalize(0.5), closeTo(0.375, 0.01));
    });
  });
}
