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
      expect(find.byType(Text), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(1280, 720));
      await tester.pumpAndSettle();
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Text overflow with accessibility font settings', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(320, 480));
      tester.binding.platformDispatcher.textScaleFactorTestOverride = 2.0;
      await tester.pumpAndSettle();
      expect(find.byType(Text), findsOneWidget);

      tester.binding.platformDispatcher.textScaleFactorTestOverride = 1.0;
    });

    testWidgets('Text overflow with extreme string lengths', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final textFinder = find.text('a'.repeat(1000));
      expect(textFinder, findsOneWidget);
    });
  });
}
