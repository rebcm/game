import 'package:flutter/material.dart';

class WidgetTracker {
  int _rebuildCount = 0;

  Future<void> init() async {}

  Future<void> startTracking() async {
    // Implement tracking logic here
  }

  Future<int> stopTracking() async {
    return _rebuildCount;
  }
}
