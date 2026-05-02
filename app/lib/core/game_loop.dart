import 'package:flame/game.dart';
import 'package:rebcm/core/rendering/voxel_renderer.dart';
import 'package:rebcm/world/chunk_manager.dart';

class GameLoop extends FlameGame {
  late VoxelRenderer _voxelRenderer;
  late ChunkManager _chunkManager;

  @override
  Future<void> onLoad() async {
    _voxelRenderer = VoxelRenderer();
    _voxelRenderer.init();
    _chunkManager = ChunkManager();
    _chunkManager.init(_voxelRenderer);
    _chunkManager.generateChunks();
  }

  @override
  void update(double dt) {
    _chunkManager.update();
  }

  @override
  void render(Canvas canvas) {
    _voxelRenderer.render();
  }
}
