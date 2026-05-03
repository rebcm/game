import 'package:test/test.dart';
import 'package:rebcm/vehicles/vehicle_physics.dart';

void main() {
  test('default vehicle physics is created correctly', () {
    final vehiclePhysics = VehiclePhysics.defaultVehicle();
    expect(vehiclePhysics.mass, isNotNull);
    expect(vehiclePhysics.centerOfMassX, 0);
    expect(vehiclePhysics.centerOfMassY, 0.5);
    expect(vehiclePhysics.centerOfMassZ, 0);
  });
}
