import 'package:leak_tracker/leak_tracker.dart';

class LeakTrackerUtil {
  static void initializeLeakTracking() {
    LeakTracker.startTracking();
  }

  static void disposeLeakTracking() {
    LeakTracker.stopTracking();
  }
}
