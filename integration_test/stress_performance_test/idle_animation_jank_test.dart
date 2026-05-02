import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Idle animation jank test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Wait for the idle animation to start
    await tester.pump(Duration(seconds: 2));

    // Measure frame rate and CPU usage for 10 seconds
    for (int i = 0; i < 100; i++) {
      await tester.pump(Duration(milliseconds: 100));
      // Add frame rate and CPU usage measurement logic here
    }
  });
}
