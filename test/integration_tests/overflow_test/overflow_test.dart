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

    testWidgets('Text overflow with extra large font size', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.binding.setFontSizeFactor(2.0);
      await tester.pumpAndSettle();
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Text overflow with extreme string length', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final extremeString = 'a' * 1000;
      await tester.enterText(find.byType(TextField), extremeString);
      await tester.pumpAndSettle();
      expect(find.text(extremeString), findsOneWidget);
    });
  });
}
