import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/domain/exceptions/invalid_coordinate_exception.dart';
import 'package:rebcm/domain/validation/coordinate_validation.dart';

void main() {
  group('CoordinateValidation', () {
    const worldSize = 16;

    test('should not throw exception for valid coordinates', () {
      expect(() => CoordinateValidation.validate(0, 0, worldSize), returnsNormally);
      expect(() => CoordinateValidation.validate(7, 7, worldSize), returnsNormally);
      expect(() => CoordinateValidation.validate(worldSize - 1, worldSize - 1, worldSize), returnsNormally);
    });

    test('should throw InvalidCoordinateException for negative x', () {
      expect(() => CoordinateValidation.validate(-1, 0, worldSize), throwsA(isA<InvalidCoordinateException>()));
    });

    test('should throw InvalidCoordinateException for x out of bounds', () {
      expect(() => CoordinateValidation.validate(worldSize, 0, worldSize), throwsA(isA<InvalidCoordinateException>()));
    });

    test('should throw InvalidCoordinateException for negative z', () {
      expect(() => CoordinateValidation.validate(0, -1, worldSize), throwsA(isA<InvalidCoordinateException>()));
    });

    test('should throw InvalidCoordinateException for z out of bounds', () {
      expect(() => CoordinateValidation.validate(0, worldSize, worldSize), throwsA(isA<InvalidCoordinateException>()));
    });
  });
}
