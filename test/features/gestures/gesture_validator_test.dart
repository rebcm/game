import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/gestures/gesture_validator.dart';

void main() {
  group('GestureValidator', () {
    test('should validate correct gesture', () {
      final validator = GestureValidator();
      expect(validator.validateGesture('LongPress', 'LongPress'), true);
    });

    test('should invalidate incorrect gesture', () {
      final validator = GestureValidator();
      expect(validator.validateGesture('DoubleTap', 'LongPress'), false);
    });
  });
}
