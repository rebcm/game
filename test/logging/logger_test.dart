import 'package:test/test.dart';
import 'package:game/logging/logger.dart';

void main() {
  test('Logger logs a message', () {
    expect(() => Logger.log('Test log message'), returnsNormally);
  });

  test('Logger logs an error', () {
    expect(() => Logger.error('Test error message'), returnsNormally);
  });
}
