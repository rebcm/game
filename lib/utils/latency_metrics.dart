import 'package:flutter/foundation.dart';

class LatencyMetrics with ChangeNotifier {
  double _coldStartLatency = 0;
  double _cachedStartLatency = 0;

  double get coldStartLatency => _coldStartLatency;
  double get cachedStartLatency => _cachedStartLatency;

  void updateColdStartLatency(double latency) {
    _coldStartLatency = latency;
    notifyListeners();
  }

  void updateCachedStartLatency(double latency) {
    _cachedStartLatency = latency;
    notifyListeners();
  }
}
