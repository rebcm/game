import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test different resolutions', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test different resolutions
    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpAndSettle();
    await tester.binding.setSurfaceSize(const Size(375, 667));
    await tester.pumpAndSettle();
    await tester.binding.setSurfaceSize(const Size(414, 896));
    await tester.pumpAndSettle();

    // Add your test logic here
  });
}
