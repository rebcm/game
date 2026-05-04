import 'package:flutter_test/flutter_test.dart';
import 'package:game/exceptions/coordinate_out_of_bounds_exception.dart';
import 'package:game/services/coordinate_validation_service.dart';

void main() {
  group('CoordinateValidationService', () {
    late CoordinateValidationService service;

    setUp(() {
      service = CoordinateValidationService();
    });

    test('should not throw exception for valid coordinates', () {
      expect(() => service.validateCoordinates(0, 0), returnsNormally);
      expect(() => service.validateCoordinates(255, 255), returnsNormally);
    });

    test('should throw CoordinateOutOfBoundsException for negative x', () {
      expect(() => service.validateCoordinates(-1, 0), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should throw CoordinateOutOfBoundsException for negative z', () {
      expect(() => service.validateCoordinates(0, -1), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should throw CoordinateOutOfBoundsException for x out of upper bound', () {
      expect(() => service.validateCoordinates(256, 0), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should throw CoordinateOutOfBoundsException for z out of upper bound', () {
      expect(() => service.validateCoordinates(0, 256), throwsA(isA<CoordinateOutOfBoundsException>()));
    });
  });
}
