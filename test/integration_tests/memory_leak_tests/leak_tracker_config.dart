import 'package:leak_tracker/leak_tracker.dart';

void configureLeakTracker() {
  LeakTracker.startTracking();
  LeakTracker.addListener((leaks) {
    if (leaks.isNotEmpty) {
      throw Exception('Memory leak detected');
    }
  });
}
