class MassDefinitions {
  static const double blockMass = 1.0;
  static const double playerMass = 50.0;
  static const double vehicleMass = 200.0;
  static const Map<String, double> objectMasses = {
    'dirt_block': blockMass,
    'stone_block': blockMass * 2,
    'player': playerMass,
    'vehicle': vehicleMass,
  };
}
