import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/memory_leak_tracker.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('Memory leak test', (tester) async {
    await tester.runAsync(() async {
      await MemoryLeakTracker.trackMemoryLeak();
    });
  });
}
