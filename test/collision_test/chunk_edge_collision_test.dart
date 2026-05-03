import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk_manager.dart';
import 'package:game/player.dart';
import 'package:mockito/mockito.dart';

class MockChunkManager extends Mock implements ChunkManager {}

void main() {
  group('Chunk Edge Collision Test', () {
    late Player player;
    late ChunkManager chunkManager;

    setUp(() {
      player = Player();
      chunkManager = MockChunkManager();
    });

    test('should detect collision when player is on the edge of two chunks', () {
      // Arrange
      when(chunkManager.getChunk(any)).thenReturn(null);

      // Act
      player.position = Vector3(16.0, 0.0, 0.0); // Edge between two chunks

      // Assert
      expect(player.isColliding(chunkManager), true);
    });

    test('should not detect collision when player is not on the edge', () {
      // Arrange
      when(chunkManager.getChunk(any)).thenReturn(null);

      // Act
      player.position = Vector3(10.0, 0.0, 0.0); // Not on the edge

      // Assert
      expect(player.isColliding(chunkManager), false);
    });
  });
}
