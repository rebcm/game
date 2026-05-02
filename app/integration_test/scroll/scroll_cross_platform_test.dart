import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Scroll Cross-Platform Test', () {
    testWidgets('Scroll test on different platforms', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Open inventory
      await tester.tap(find.byTooltip('Open Inventory'));
      await tester.pumpAndSettle();

      // Perform scroll action
      await tester.drag(find.byType(ListView), Offset(0, -100));
      await tester.pumpAndSettle();

      // Verify scroll result
      expect(find.text('Dirt'), findsOneWidget);
    });
  });
}
