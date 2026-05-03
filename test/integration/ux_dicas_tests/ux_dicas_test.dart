import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UX Dicas Tests', () {
    testWidgets('should display dica when player is in specific scenario', (tester) async {
      await tester.pumpWidget(MyApp());

      // Simulate player interaction
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Check if dica is displayed
      expect(find.text('Dica: Você pode criar blocos!'), findsOneWidget);
    });

    testWidgets('should not display dica when player is not in specific scenario', (tester) async {
      await tester.pumpWidget(MyApp());

      // Simulate player interaction
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Simulate player leaving the scenario
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Check if dica is not displayed
      expect(find.text('Dica: Você pode criar blocos!'), findsNothing);
    });
  });
}
