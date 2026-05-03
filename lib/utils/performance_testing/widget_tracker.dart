import 'package:flutter/material.dart';

class WidgetTracker {
  final Map<String, int> _rebuildCounts = {};

  void startTracking() {
    // Implement logic to start tracking rebuilds
  }

  void stopTracking() {
    // Implement logic to stop tracking rebuilds
  }

  int getRebuildCount(String widgetName) {
    return _rebuildCounts[widgetName] ?? 0;
  }
}
