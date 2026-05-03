import 'package:flutter/material.dart';
import 'package:memory_info/memory_info.dart';

class StressTestHelper {
  static Future<void> checkMemoryUsage() async {
    final memoryInfo = await MemoryInfo.currentRSS;
    print('Current memory usage: $memoryInfo');
  }
}
