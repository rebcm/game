import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/logging/package_logger.dart';
import 'package:logger/logger.dart';

void main() {
  group('PackageLogger', () {
    test('logs package sequence correctly', () {
      final List<int> packageIds = [1, 2, 3];
      PackageLogger.logPackageSequence(packageIds);
      // Verify log output
    });

    test('logs missing packages correctly', () {
      final List<int> expectedIds = [1, 2, 3];
      final List<int> actualIds = [1, 3];
      PackageLogger.logMissingPackages(expectedIds, actualIds);
      // Verify log output
    });
  });
}
