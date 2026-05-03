import 'package:leak_tracker/leak_tracker.dart';

void configureLeakTracker() {
  LeakTracker.config = LeakTrackerConfig(
    checkLeaksOnDispose: true,
    onLeak: (leak) => throw Exception('Memory leak detected: $leak'),
  );
}
