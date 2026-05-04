import 'package:flutter_test/flutter_test.dart';
import 'package:game/constants/epsilon.dart';

void main() {
  group('Epsilon', () {
    test('areEqual should return true for equal numbers', () {
      expect(Epsilon.areEqual(1.0, 1.0), isTrue);
    });

    test('areEqual should return true for numbers within epsilon', () {
      expect(Epsilon.areEqual(1.0, 1.00001), isTrue);
    });

    test('areEqual should return false for numbers outside epsilon', () {
      expect(Epsilon.areEqual(1.0, 1.1), isFalse);
    });
  });
}
