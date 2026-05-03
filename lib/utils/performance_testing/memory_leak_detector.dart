import 'dart:developer' as dev;
import 'package:leak_tracker/leak_tracker.dart';
import 'package:memory_info/memory_info.dart';

class MemoryLeakDetector {
  Future<void> detectMemoryLeak() async {
    final memoryInfo = await MemoryInfo.currentMemoryUsage();
    dev.log('Memory usage: ${memoryInfo.usedMemory}');
    LeakTracker.assertNoLeaks();
  }
}
