import 'package:flutter/material.dart';
import 'package:leak_tracker/leak_tracker.dart';

class LeakDetector {
  bool _hasLeaks = false;

  bool get hasLeaks => _hasLeaks;

  Future<void> watch(WidgetTester tester, Future<void> Function() callback) async {
    await LeakTracking.watch(callback);
    _hasLeaks = LeakTracking.hasLeaks;
  }
}
