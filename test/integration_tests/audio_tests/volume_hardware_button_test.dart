import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test volume hardware button', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate volume button press
    await tester.binding.platformDispatcher.simulateHardwareVolumeButtonPress();
    await tester.pumpAndSettle();

    // Verify the volume has changed
    // Add your verification logic here
  });
}
