import 'package:flutter_test/flutter_test.dart';
import 'package:game/exceptions/coordinate_out_of_bounds_exception.dart';
import 'package:game/services/coordinate_validation_service.dart';
import 'package:game/services/world_service.dart';

void main() {
  group('WorldService', () {
    late WorldService worldService;
    late CoordinateValidationService coordinateValidationService;

    setUp(() {
      coordinateValidationService = CoordinateValidationService();
      worldService = WorldService(coordinateValidationService);
    });

    test('should validate coordinates on getBlock', () {
      expect(() => worldService.getBlock(-1, 0), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should validate coordinates on putBlock', () {
      expect(() => worldService.putBlock(256, 0), throwsA(isA<CoordinateOutOfBoundsException>()));
    });
  });
}
