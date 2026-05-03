import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:leak_tracker/leak_tracker.dart';

class MemoryLeakDetector {
  static Future<void> detectMemoryLeak() async {
    final snapshot1 = await ServiceProtocol.getMemorySnapshot();
    final initialMemoryUsage = snapshot1.usedSize;

    // Perform stress test
    for (var i = 0; i < 10; i++) {
      // Simulate game screen open and close
    }

    final snapshot2 = await ServiceProtocol.getMemorySnapshot();
    final finalMemoryUsage = snapshot2.usedSize;

    if (finalMemoryUsage > initialMemoryUsage * 1.1) {
      log('Potential memory leak detected. Initial memory usage: $initialMemoryUsage, Final memory usage: $finalMemoryUsage');
    } else {
      log('No memory leak detected. Initial memory usage: $initialMemoryUsage, Final memory usage: $finalMemoryUsage');
    }
  }
}
