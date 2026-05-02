import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_cleanup_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test performance do jogo', (tester) async {
    // Setup do teste
    await tester.pumpAndSettle();

    // Execução do teste
    // ...

    // Cleanup após o teste
    await TestCleanupHelper.cleanupTestEnvironment();
  });
}
