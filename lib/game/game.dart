import 'package:flame/game.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:rebcm/services/chunking/chunk_manager.dart';

class RebecaGame extends FlameGame {
  late ChunkManager _chunkManager;

  @override
  Future<void> onLoad() async {
    _chunkManager = ChunkManager();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _chunkManager.updateChunks(0, 0); // Update with player's position
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _chunkManager.getChunks().forEach((chunk) {
      // Render chunk
    });
  }
}
