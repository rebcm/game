import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Text Overflow Test', () {
    testWidgets('Text overflow test on different resolutions', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.binding.window.physicalSizeTestValue = const Size(320, 480);
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = const Size(1280, 720);
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);
    });

    testWidgets('Text overflow test with extra large font size', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.binding.window.textScaleFactorTestValue = 2.0;
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);
    });

    testWidgets('Text overflow test with extreme length strings', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assuming there's a text widget with a very long string
      await tester.enterText(find.byType(TextField), 'a' * 1000);
      await tester.pumpAndSettle();

      expect(find.text('a' * 1000), findsOneWidget);
    });
  });
}
