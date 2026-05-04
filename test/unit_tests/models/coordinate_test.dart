import 'package:test/test.dart';
import 'package:game/models/coordinate.dart';

void main() {
  group('Coordinate', () {
    test('should create coordinate with x and z', () {
      final coordinate = Coordinate(x: 10, z: 20);
      expect(coordinate.x, 10);
      expect(coordinate.z, 20);
    });

    test('should return correct string representation', () {
      final coordinate = Coordinate(x: 10, z: 20);
      expect(coordinate.toString(), 'Coordinate(x: 10, z: 20)');
    });
  });
}
