import 'package:flutter_test/flutter_test.dart';
import 'package:game/physics_engine.dart';

void main() {
  group('Boundary Collision Test', () {
    test('should detect collision at chunk boundary with minimal offset', () {
      final physicsEngine = PhysicsEngine();
      final position = Vector3(15.9999, 0, 0); // minimal offset from chunk boundary
      final result = physicsEngine.checkCollision(position);
      expect(result, isTrue);
    });

    test('should detect collision at negative chunk boundary with minimal offset', () {
      final physicsEngine = PhysicsEngine();
      final position = Vector3(-0.0001, 0, 0); // minimal offset from negative chunk boundary
      final result = physicsEngine.checkCollision(position);
      expect(result, isTrue);
    });

    test('should not detect collision outside boundary', () {
      final physicsEngine = PhysicsEngine();
      final position = Vector3(16.001, 0, 0); // outside chunk boundary
      final result = physicsEngine.checkCollision(position);
      expect(result, isFalse);
    });
  });
}
