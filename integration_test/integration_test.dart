import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration test entry point', (tester) async {
    app.main();
    await tester.pumpAndSettle();
  });

  group('Audio Integration Tests', () {
    testWidgets('Audio volume test', (tester) async {
      await tester.runAsync(() async {
        await audioVolumeTest(tester);
      });
    });
  });
}
