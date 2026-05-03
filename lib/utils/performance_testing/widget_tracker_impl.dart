import 'package:flutter/material.dart';
import 'package:game/utils/performance_testing/widget_tracker.dart';

class WidgetTrackerImpl implements WidgetTracker {
  @override
  Future<void> init() async {
    // Initialize widget tracker
  }

  @override
  Future<int> getRebuildCount() async {
    // Return rebuild count
    return 0;
  }
}
