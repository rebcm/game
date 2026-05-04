import 'package:flutter_test/flutter_test.dart';
import 'package:game/logging/logging.dart';

void main() {
  group('Logging Test', () {
    test('should log info message correctly', () async {
      // Arrange
      final logger = Logger();

      // Act
      logger.info('Test info message');

      // Assert
      // Add assertion logic here if needed
    });

    test('should log error message correctly', () async {
      // Arrange
      final logger = Logger();

      // Act
      logger.error('Test error message');

      // Assert
      // Add assertion logic here if needed
    });
  });
}
