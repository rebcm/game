import 'package:flutter/material.dart';
import 'package:leak_tracker/leak_tracker.dart';

class MemoryLeakChecker {
  bool isDisposed(StatefulElement element) {
    return LeakTracker.isDisposed(element.state);
  }
}
