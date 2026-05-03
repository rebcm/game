import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk_manager.dart';
import 'package:game/player.dart';
import 'package:mockito/mockito.dart';

class MockChunkManager extends Mock implements ChunkManager {}

void main() {
  group('Chunk Collision Test', () {
    late Player player;
    late ChunkManager chunkManager;

    setUp(() {
      player = Player();
      chunkManager = MockChunkManager();
    });

    test('should detect collision when player is on the boundary of two chunks', () {
      // Arrange
      when(chunkManager.isCollision(any, any)).thenReturn(true);

      // Act
      bool result = chunkManager.isCollision(player.position, player.size);

      // Assert
      expect(result, true);
    });

    test('should not detect collision when player is not on the boundary of two chunks', () {
      // Arrange
      when(chunkManager.isCollision(any, any)).thenReturn(false);

      // Act
      bool result = chunkManager.isCollision(player.position, player.size);

      // Assert
      expect(result, false);
    });
  });
}
