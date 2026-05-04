import '../exceptions/coordinate_out_of_bounds_exception.dart';
import '../models/coordinate.dart';

class CoordinateValidator {
  static const int minX = 0;
  static const int maxX = 255;
  static const int minZ = 0;
  static const int maxZ = 255;

  void validate(Coordinate coordinate) {
    if (coordinate.x < minX || coordinate.x > maxX) {
      throw CoordinateOutOfBoundsException('X coordinate ${coordinate.x} is out of bounds [$minX, $maxX]');
    }
    if (coordinate.z < minZ || coordinate.z > maxZ) {
      throw CoordinateOutOfBoundsException('Z coordinate ${coordinate.z} is out of bounds [$minZ, $maxZ]');
    }
  }
}
