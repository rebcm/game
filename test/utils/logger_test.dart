import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/logger.dart';

void main() {
  test('Logger logError', () {
    Logger.logError('Test error message');
  });

  test('Logger logInfo', () {
    Logger.logInfo('Test info message');
  });
}
