import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('coverage test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add tests here to drive the app and verify its functionality
  });
}
