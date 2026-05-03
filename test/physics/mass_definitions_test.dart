import 'package:test/test.dart';
import 'package:rebcm/physics/mass_definitions.dart';

void main() {
  test('object masses are defined correctly', () {
    expect(MassDefinitions.objectMasses['dirt_block'], MassDefinitions.blockMass);
    expect(MassDefinitions.objectMasses['stone_block'], MassDefinitions.blockMass * 2);
    expect(MassDefinitions.objectMasses['player'], MassDefinitions.playerMass);
    expect(MassDefinitions.objectMasses['vehicle'], MassDefinitions.vehicleMass);
  });
}
