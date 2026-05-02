import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/memory/memory_profiler.dart';

void main() {
  group('MemoryProfiler', () {
    test('captureMemorySnapshot adds a new snapshot', () {
      var memoryProfiler = MemoryProfiler();
      memoryProfiler.captureMemorySnapshot();
      expect(memoryProfiler.memorySnapshots.length, 1);
    });

    test('clearMemorySnapshots clears all snapshots', () {
      var memoryProfiler = MemoryProfiler();
      memoryProfiler.captureMemorySnapshot();
      memoryProfiler.clearMemorySnapshots();
      expect(memoryProfiler.memorySnapshots.length, 0);
    });
  });
}
