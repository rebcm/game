import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';

void configureLeakTrackerTests() {
  LeakTracker.testing.enable();
}
