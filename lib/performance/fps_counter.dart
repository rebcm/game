import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FpsCounter with ChangeNotifier {
  double _fps = 0;
  int _jankFrames = 0;
  int _totalFrames = 0;

  double get fps => _fps;
  double get jankFrames => _jankFrames.toDouble() / _totalFrames.toDouble() * 100;

  FpsCounter() {
    SchedulerBinding.instance!.addPersistentFrameCallback((_) {
      _totalFrames++;
      // Calculate FPS and jank frames here
      notifyListeners();
    });
  }
}
