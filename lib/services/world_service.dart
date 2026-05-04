import 'package:game/services/coordinate_validation_service.dart';

class WorldService {
  final CoordinateValidationService _coordinateValidationService;

  WorldService(this._coordinateValidationService);

  void getBlock(int x, int z) {
    _coordinateValidationService.validateCoordinates(x, z);
    // Existing logic to get block
  }

  void putBlock(int x, int z) {
    _coordinateValidationService.validateCoordinates(x, z);
    // Existing logic to put block
  }
}
