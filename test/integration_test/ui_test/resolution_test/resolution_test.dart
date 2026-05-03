import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test UI in different resolutions', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Test different resolutions
    await tester.binding.window.physicalSizeTestValue = const Size(320, 480); // iPhone SE
    await tester.binding.window.devicePixelRatioTestValue = 2.0;
    await tester.pumpAndSettle();

    // Add UI test logic here

    await tester.binding.window.physicalSizeTestValue = const Size(480, 800); // Old Android devices
    await tester.binding.window.devicePixelRatioTestValue = 1.5;
    await tester.pumpAndSettle();

    // Add UI test logic here

    await tester.binding.window.clearPhysicalSizeTestValue();
    await tester.binding.window.clearDevicePixelRatioTestValue();
  });
}
