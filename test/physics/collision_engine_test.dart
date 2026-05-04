import 'package:flutter_test/flutter_test.dart';
import 'package:game/physics/collision_engine.dart';

void main() {
  late CollisionEngine collisionEngine;

  setUp(() {
    collisionEngine = CollisionEngine();
  });

  test('Collision engine correctly compares almost equal numbers', () {
    expect(collisionEngine.areAlmostEqual(0.0001, 0.0002), isFalse);
    expect(collisionEngine.areAlmostEqual(0.000099, 0.0001), isTrue);
  });
}
