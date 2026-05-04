import 'package:test/test.dart';
import 'package:game/models/coordinate.dart';
import 'package:game/services/coordinate_validator.dart';
import 'package:game/services/world_service.dart';
import 'package:game/exceptions/coordinate_out_of_bounds_exception.dart';

void main() {
  group('WorldService', () {
    late WorldService worldService;
    late CoordinateValidator coordinateValidator;

    setUp(() {
      coordinateValidator = CoordinateValidator();
      worldService = WorldService(coordinateValidator);
    });

    test('should validate coordinate on getBlock', () {
      final coordinate = Coordinate(x: -1, z: 20);
      expect(() => worldService.getBlock(coordinate), throwsA(isA<CoordinateOutOfBoundsException>()));
    });

    test('should validate coordinate on putBlock', () {
      final coordinate = Coordinate(x: 10, z: 256);
      expect(() => worldService.putBlock(coordinate), throwsA(isA<CoordinateOutOfBoundsException>()));
    });
  });
}
