import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/logging/logging.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Logging Integration Test', () {
    testWidgets('should log info message', (tester) async {
      // Arrange
      await app.main();

      // Act
      final logger = Logger();
      logger.info('Info message');

      // Assert
      // Add assertion here
    });

    testWidgets('should log error message', (tester) async {
      // Arrange
      await app.main();

      // Act
      final logger = Logger();
      logger.error('Error message');

      // Assert
      // Add assertion here
    });
  });
}
