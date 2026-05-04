import 'package:test/test.dart';
import 'package:game/logging/logging.dart';

void main() {
  group('Logging Test', () {
    test('should log info message', () {
      // Arrange
      final logger = Logger();

      // Act
      logger.info('Info message');

      // Assert
      // Add assertion here
    });

    test('should log error message', () {
      // Arrange
      final logger = Logger();

      // Act
      logger.error('Error message');

      // Assert
      // Add assertion here
    });
  });
}
