import 'package:game/exceptions/coordinate_out_of_bounds_exception.dart';

class CoordinateValidationService {
  static const int worldSize = 256; // Assuming world size is 256x256

  void validateCoordinates(int x, int z) {
    if (x < 0 || x >= worldSize || z < 0 || z >= worldSize) {
      throw CoordinateOutOfBoundsException('Coordinates ($x, $z) are out of bounds. World size is $worldSize x $worldSize');
    }
  }
}
