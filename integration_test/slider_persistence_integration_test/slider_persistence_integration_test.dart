import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Slider persistence integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implement logic to test slider persistence across app restarts
    // await tester.tap(find.byType(Slider));
    // await tester.pumpAndSettle();
    // Verify slider value is persisted after app restart
  });
}
