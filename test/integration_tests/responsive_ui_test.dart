import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Responsive UI Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test different resolutions and UI elements
    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);

    // Test UI overlay
    await tester.tap(find.text('Build'));
    await tester.pumpAndSettle();
    expect(find.text('Block Type'), findsOneWidget);

    // Test text expansion in different languages
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Português'));
    await tester.pumpAndSettle();
  });
}
