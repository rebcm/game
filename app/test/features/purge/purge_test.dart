import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/features/persistence/persistence_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Purge Process', () {
    testWidgets('should remove obsolete artifacts', (tester) async {
      // Arrange
      final persistenceManager = PersistenceManager();
      await persistenceManager.init();

      // Act
      await persistenceManager.purgeObsoleteArtifacts();

      // Assert
      expect(await persistenceManager.getArtifactCount(), 0);
    });
  });
}
