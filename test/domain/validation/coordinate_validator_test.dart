import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/domain/exceptions.dart';
import 'package:rebcm/domain/validation/coordinate_validator.dart';

void main() {
  group('CoordinateValidator', () {
    test('should not throw exception for valid coordinates', () {
      expect(() => CoordinateValidator.validate(0, 0), returnsNormally);
    });

    test('should throw exception for X coordinate out of bounds', () {
      expect(() => CoordinateValidator.validate(-101, 0), throwsA(isA<CoordinateOutOfBoundsException>()));
      expect(() => CoordinateValidator.validate(101, 0), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should throw exception for Z coordinate out of bounds', () {
      expect(() => CoordinateValidator.validate(0, -101), throwsA(isA<CoordinateOutOfBoundsException>()));
      expect(() => CoordinateValidator.validate(0, 101), throwsA(isA<CoordinateOutOfBoundsException>()));
    });
  });
}
