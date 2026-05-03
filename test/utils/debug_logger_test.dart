import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/debug_logger.dart';

void main() {
  group('DebugLogger', () {
    test('initial state is disabled', () {
      final debugLogger = DebugLogger();
      expect(debugLogger.isEnabled, false);
    });

    test('toggle enables and disables', () {
      final debugLogger = DebugLogger();
      debugLogger.toggle();
      expect(debugLogger.isEnabled, true);
      debugLogger.toggle();
      expect(debugLogger.isEnabled, false);
    });

    test('log prints when enabled', () {
      final debugLogger = DebugLogger();
      debugLogger.toggle();
      expect(() => debugLogger.log('test'), prints('DEBUG: test\n'));
    });

    test('log does not print when disabled', () {
      final debugLogger = DebugLogger();
      expect(() => debugLogger.log('test'), isNot(prints('DEBUG: test\n')));
    });
  });
}
