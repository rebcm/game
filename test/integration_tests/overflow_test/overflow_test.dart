import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Overflow Test', () {
    testWidgets('Text overflow on different resolutions', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpAndSettle();
      expect(find.text('Rebeca'), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(1280, 720));
      await tester.pumpAndSettle();
      expect(find.text('Rebeca'), findsOneWidget);
    });

    testWidgets('Text overflow with accessibility font settings', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpAndSettle();

      final textScaleFactor = 2.0; // Extra Large font size
      await tester.binding.setTextScaleFactor(textScaleFactor);
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);
    });

    testWidgets('Text overflow with extreme string lengths', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpAndSettle();

      final extremelyLongString = 'Rebeca' * 100;
      await tester.enterText(find.byType(TextField), extremelyLongString);
      await tester.pumpAndSettle();

      expect(find.text(extremelyLongString), findsOneWidget);
    });
  });
}
