import '../models/coordinate.dart';
import '../services/coordinate_validator.dart';

class WorldService {
  final CoordinateValidator _coordinateValidator;

  WorldService(this._coordinateValidator);

  void getBlock(Coordinate coordinate) {
    _coordinateValidator.validate(coordinate);
    // Existing logic to get block
  }

  void putBlock(Coordinate coordinate) {
    _coordinateValidator.validate(coordinate);
    // Existing logic to put block
  }
}
