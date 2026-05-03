import 'package:rebcm/physics/mass_definitions.dart';

class VehiclePhysics {
  final double mass;
  final double centerOfMassX;
  final double centerOfMassY;
  final double centerOfMassZ;

  VehiclePhysics({
    required this.mass,
    required this.centerOfMassX,
    required this.centerOfMassY,
    required this.centerOfMassZ,
  });

  factory VehiclePhysics.defaultVehicle() {
    return VehiclePhysics(
      mass: MassDefinitions.objectMasses['vehicle'] ?? 0,
      centerOfMassX: 0,
      centerOfMassY: 0.5,
      centerOfMassZ: 0,
    );
  }
}
