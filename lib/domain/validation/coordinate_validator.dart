import 'package:rebcm/domain/exceptions.dart';

class CoordinateValidator {
  static const int _minCoordinate = -100;
  static const int _maxCoordinate = 100;

  static void validate(int x, int z) {
    if (x < _minCoordinate || x > _maxCoordinate) {
      throw CoordinateOutOfBoundsException('X coordinate is out of bounds');
    }
    if (z < _minCoordinate || z > _maxCoordinate) {
      throw CoordinateOutOfBoundsException('Z coordinate is out of bounds');
    }
  }
}
