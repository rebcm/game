import 'package:flutter/material.dart';
import 'package:game/utils/performance_testing/widget_tracker.dart';

class WidgetTrackerImpl implements WidgetTracker {
  @override
  Future<void> init() async {}

  @override
  Future<void> startTracking() async {
    // Implement actual tracking logic here
  }

  @override
  Future<int> stopTracking() async {
    // Return actual rebuild count
    return 0;
  }
}
