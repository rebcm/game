import 'package:flutter_test/flutter_test.dart';
import 'package:game/model/voxel.dart';

void main() {
  test('Testa a criação de um voxel', () {
    Voxel voxel = Voxel(1, 2, 3);
    expect(voxel.x, 1);
    expect(voxel.y, 2);
    expect(voxel.z, 3);
  });
}
