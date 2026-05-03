import 'package:flutter_test/flutter_test.dart';
import 'package:game/physics_engine.dart';

void main() {
  group('Physics Engine Floating Point Precision Tests', () {
    test('should detect collision at chunk borders with minimal offset', () {
      final physicsEngine = PhysicsEngine();
      const offset = 0.0001;
      // Assume a chunk size of 16 for this example
      const chunkSize = 16.0;
      final positionAtChunkBorder = chunkSize - offset;

      final result = physicsEngine.checkCollision(positionAtChunkBorder);

      expect(result, isTrue);
    });

    test('should not detect collision just outside chunk borders', () {
      final physicsEngine = PhysicsEngine();
      const offset = 0.0001;
      const chunkSize = 16.0;
      final positionJustOutside = chunkSize + offset;

      final result = physicsEngine.checkCollision(positionJustOutside);

      expect(result, isFalse);
    });
  });
}
