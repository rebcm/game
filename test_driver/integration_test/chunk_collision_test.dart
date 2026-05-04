import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('chunk collision test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Perform actions to test chunk collision
    // Verify that colliders are correctly synced between chunks
  });
}
