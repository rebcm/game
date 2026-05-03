import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/domain/exceptions/invalid_coordinate_exception.dart';
import 'package:rebcm/domain/validations/coordinate_validation.dart';

void main() {
  group('CoordinateValidation', () {
    test('should not throw exception for valid coordinates', () {
      expect(() => CoordinateValidation.validate(0, 0, 10), returnsNormally);
      expect(() => CoordinateValidation.validate(9, 9, 10), returnsNormally);
    });

    test('should throw InvalidCoordinateException for invalid coordinates', () {
      expect(() => CoordinateValidation.validate(-1, 0, 10), throwsA(isA<InvalidCoordinateException>()));
      expect(() => CoordinateValidation.validate(10, 0, 10), throwsA(isA<InvalidCoordinateException>()));
      expect(() => CoordinateValidation.validate(0, -1, 10), throwsA(isA<InvalidCoordinateException>()));
      expect(() => CoordinateValidation.validate(0, 10, 10), throwsA(isA<InvalidCoordinateException>()));
    });
  });
}
