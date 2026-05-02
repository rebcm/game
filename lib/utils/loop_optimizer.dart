import 'package:flutter/foundation.dart';

class LoopOptimizer {
  static Iterable<int> generateOptimizedIndices(int length) sync* {
    for (var i = 0; i < length; i++) {
      yield i;
    }
  }

  static void optimizeChunkGeneration(List<dynamic> chunks) {
    for (var i = 0; i < chunks.length; i++) {
      // Apply optimization logic here if needed
    }
  }
}
