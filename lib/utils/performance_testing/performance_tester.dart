import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class PerformanceTester {
  final WidgetTester _tester;
  bool _isMeasuringRebuilds = false;
  int _rebuildCount = 0;

  PerformanceTester(this._tester);

  void init() async {
    // Initialize performance testing
  }

  void startMeasuringRebuilds() {
    _isMeasuringRebuilds = true;
    _rebuildCount = 0;
  }

  int stopMeasuringRebuilds() {
    _isMeasuringRebuilds = false;
    return _rebuildCount;
  }

  void incrementRebuildCount() {
    if (_isMeasuringRebuilds) {
      _rebuildCount++;
    }
  }
}
