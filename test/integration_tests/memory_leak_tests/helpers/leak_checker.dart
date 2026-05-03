import 'package:leak_tracker/leak_tracker.dart';

class LeakChecker {
  static void checkLeaks() {
    final leaks = LeakTracking.getLeaks();
    expect(leaks, isEmpty);
  }
}
