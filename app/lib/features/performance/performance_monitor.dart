import 'package:flutter/foundation.dart';

class PerformanceMonitor with ChangeNotifier {
  double _fps = 0;

  double get fps => _fps;

  void updateFPS(double fps) {
    _fps = fps;
    notifyListeners();
  }
}
