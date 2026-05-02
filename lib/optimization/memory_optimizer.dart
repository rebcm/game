import 'package:flutter/foundation.dart';

class MemoryOptimizer {
  static void optimizeList(List<dynamic> list) {
    list.removeWhere((element) => element == null);
  }

  static void optimizeLoop(List<dynamic> list, Function callback) {
    for (var i = list.length - 1; i >= 0; i--) {
      callback(list[i]);
    }
  }
}
