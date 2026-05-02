import 'package:flutter/foundation.dart';

class PerformanceManager with ChangeNotifier {
  double _averageFps = 0;

  double get averageFps => _averageFps;

  void updateFps(double fps) {
    _averageFps = fps;
    notifyListeners();
  }
}
