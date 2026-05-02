import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UI Tests', () {
    testWidgets('Inventory UI Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Inventory'));
      await tester.pumpAndSettle();

      expect(find.text('Blocks'), findsOneWidget);
      expect(find.text('Tools'), findsOneWidget);
    });

    testWidgets('Block Placement Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.byType(Block), findsOneWidget);
    });
  });
}
