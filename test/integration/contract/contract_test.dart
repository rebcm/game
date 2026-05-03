import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('contract test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add contract test logic here
  });
}
