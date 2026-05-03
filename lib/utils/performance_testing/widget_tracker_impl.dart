import 'package:flutter/material.dart';
import 'package:game/utils/performance_testing/widget_tracker.dart';

class WidgetTrackerImpl implements WidgetTracker {
  int _rebuildCount = 0;

  @override
  Future<void> trackRebuilds(AsyncCallback callback) async {
    _rebuildCount = 0;
    await callback();
  }

  @override
  int get rebuildCount => _rebuildCount;

  void incrementRebuildCount() {
    _rebuildCount++;
  }
}
