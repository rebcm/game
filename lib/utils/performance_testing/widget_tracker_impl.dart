import 'package:flutter/material.dart';
import 'package:game/utils/performance_testing/widget_tracker.dart';

class WidgetTrackerImpl implements WidgetTracker {
  @override
  void startTracking() {
    // Implement logic to start tracking rebuilds using a diagnostic or other method
  }

  @override
  void stopTracking() {
    // Implement logic to stop tracking rebuilds
  }

  @override
  int getRebuildCount(String widgetName) {
    // Implement logic to get rebuild count for a specific widget
    return 0;
  }
}
