import 'package:flutter_test/flutter_test.dart';
import 'package:game/logging/logging_collector.dart';

void main() {
  group('LoggingCollector', () {
    test('should collect log messages', () {
      final collector = LoggingCollector();
      collector.collect('Test log message');
      expect(collector.logs, contains('Test log message'));
    });

    test('should clear log messages', () {
      final collector = LoggingCollector();
      collector.collect('Test log message');
      collector.clear();
      expect(collector.logs, isEmpty);
    });
  });
}
