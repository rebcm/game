import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/logging/package_logger.dart';

void main() {
  test('PackageLogger logs packages correctly', () {
    final logger = PackageLogger();
    logger.logPackage(1, 'received');
    logger.logPackage(2, 'processed');
    expect(logger.getLog().length, 2);
  });

  test('PackageLogger validates sequence correctly', () {
    final logger = PackageLogger();
    logger.logPackage(1, 'received');
    logger.logPackage(2, 'processed');
    expect(logger.validateSequence(), true);
    logger.logPackage(4, 'processed');
    expect(logger.validateSequence(), false);
  });
}
