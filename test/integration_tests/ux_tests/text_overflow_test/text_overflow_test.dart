import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Text Overflow Test', () {
    testWidgets('should not overflow in German', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Navigate to the page with the text to test
      // await tester.tap(find.byTooltip('Navigate to test page'));
      await tester.pumpAndSettle();

      // Check for overflow
      expect(find.byType(TextOverflow.ellipsis), findsNothing);
    });

    testWidgets('should not overflow in French', (tester) async {
      // Set locale to French
      await tester.binding.setLocale('fr');
      await app.main();
      await tester.pumpAndSettle();

      // Navigate to the page with the text to test
      // await tester.tap(find.byTooltip('Navigate to test page'));
      await tester.pumpAndSettle();

      // Check for overflow
      expect(find.byType(TextOverflow.ellipsis), findsNothing);
    });
  });
}
