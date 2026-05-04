import 'package:test/test.dart';
import 'package:game/exceptions/coordinate_out_of_bounds_exception.dart';
import 'package:game/models/coordinate.dart';
import 'package:game/services/coordinate_validator.dart';

void main() {
  group('CoordinateValidator', () {
    late CoordinateValidator validator;

    setUp(() {
      validator = CoordinateValidator();
    });

    test('should not throw exception for valid coordinates', () {
      final coordinate = Coordinate(x: 10, z: 20);
      expect(() => validator.validate(coordinate), returnsNormally);
    });

    test('should throw exception for x less than min', () {
      final coordinate = Coordinate(x: -1, z: 20);
      expect(() => validator.validate(coordinate), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should throw exception for x greater than max', () {
      final coordinate = Coordinate(x: 256, z: 20);
      expect(() => validator.validate(coordinate), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should throw exception for z less than min', () {
      final coordinate = Coordinate(x: 10, z: -1);
      expect(() => validator.validate(coordinate), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should throw exception for z greater than max', () {
      final coordinate = Coordinate(x: 10, z: 256);
      expect(() => validator.validate(coordinate), throwsA(isA<CoordinateOutOfBoundsException>()));
    });
  });
}
