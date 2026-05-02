import 'package:flutter/foundation.dart';
import 'package:rebcm/utils/optimization/memory_optimizer.dart';

class ChunkManager {
  void manageChunks(List chunks) {
    MemoryOptimizer.optimizeList(chunks);
    // Other chunk management logic
  }

  void renderChunks(int length) {
    MemoryOptimizer.optimizeLoop((index) {
      // Render chunk logic
    }, length);
  }
}
