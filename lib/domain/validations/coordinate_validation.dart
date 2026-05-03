import 'package:rebcm/domain/exceptions/invalid_coordinate_exception.dart';

class CoordinateValidation {
  static void validate(int x, int z, int worldSize) {
    if (x < 0 || x >= worldSize || z < 0 || z >= worldSize) {
      throw InvalidCoordinateException('Coordenada ($x, $z) fora dos limites do mundo.');
    }
  }
}
