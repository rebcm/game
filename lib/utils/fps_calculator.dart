import 'package:flutter/scheduler.dart';

class FPSCalculator {
  static double calculateFPS() {
    // Implement FPS calculation logic here
    return SchedulerBinding.instance!.framesPerSecond;
  }
}
