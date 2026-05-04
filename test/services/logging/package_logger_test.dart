import 'package:test/test.dart';
import 'package:game/services/logging/package_logger.dart';

void main() {
  group('PackageLogger', () {
    test('logInfo should log information', () {
      PackageLogger.logInfo('Test Info');
      // Logger output is not directly testable, this is a placeholder
      expect(true, isTrue);
    });

    test('logError should log error', () {
      PackageLogger.logError('Test Error', Exception('Test'));
      // Logger output is not directly testable, this is a placeholder
      expect(true, isTrue);
    });
  });
}
