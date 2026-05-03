import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/debug_profiler.dart';

void main() {
  group('DebugProfiler', () {
    test('initial state is disabled', () {
      final profiler = DebugProfiler();
      expect(profiler.isEnabled, false);
    });

    test('toggle enables and disables', () {
      final profiler = DebugProfiler();
      profiler.toggle();
      expect(profiler.isEnabled, true);
      profiler.toggle();
      expect(profiler.isEnabled, false);
    });
  });
}
