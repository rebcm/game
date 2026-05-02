import 'package:rebcm/core/rendering/voxel_renderer.dart';

class ChunkManager {
  late VoxelRenderer _voxelRenderer;
  final int _chunkSize = 16;

  void init(VoxelRenderer voxelRenderer) {
    _voxelRenderer = voxelRenderer;
  }

  void generateChunks() {
    // Generate chunks of size _chunkSize
  }

  void update() {
    // Update chunks based on camera position
  }
}
