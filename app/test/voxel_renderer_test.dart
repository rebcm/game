import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/core/rendering/voxel_renderer.dart';

void main() {
  test('VoxelRenderer init and dispose', () {
    final voxelRenderer = VoxelRenderer();
    voxelRenderer.init();
    voxelRenderer.dispose();
  });
}
