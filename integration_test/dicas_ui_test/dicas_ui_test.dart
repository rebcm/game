import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Dicas UI Test - Validate dicas text rendering across different screen resolutions and languages', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Test different screen resolutions
    await tester.binding.setSurfaceSize(const Size(1080, 1920)); // Typical mobile resolution
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(3840, 2160)); // 4K resolution
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);

    // Test different languages
    // Assuming the app supports locale changes
    await tester.binding.setLocale(const Locale('en', 'US'));
    await tester.pumpAndSettle();
    expect(find.text('Tips'), findsOneWidget); // English translation

    await tester.binding.setLocale(const Locale('pt', 'BR'));
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget); // Portuguese translation
  });
}
