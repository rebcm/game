import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('i18n layout test', () {
    testWidgets('check detailed description layout', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the detailed description screen
      await tester.tap(find.text('Passdriver'));
      await tester.pumpAndSettle();

      // Check if the layout is correct for different locales
      await tester.binding.setLocale('de'); // German
      await tester.pumpAndSettle();
      expect(find.text('Detailed Description'), findsOneWidget);

      await tester.binding.setLocale('fr'); // French
      await tester.pumpAndSettle();
      expect(find.text('Detailed Description'), findsOneWidget);

      // Add more locale checks as needed
    });
  });
}
