import 'package:flutter/foundation.dart';

class MemoryOptimizer {
  static void optimizeList<T>(List<T> list) {
    list.removeWhere((element) => element == null);
  }

  static void optimizeLoop(void Function(int) callback, int length) {
    for (var i = 0; i < length; i++) {
      callback(i);
    }
  }
}
