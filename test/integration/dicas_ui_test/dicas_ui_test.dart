import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dicas UI test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Navigate to dicas screen
    final dicasButton = find.byTooltip('Dicas');
    expect(dicasButton, findsOneWidget);
    await tester.tap(dicasButton);
    await tester.pumpAndSettle();

    // Verify dicas content
    final dicasContent = find.text('Conteúdo de Dicas');
    expect(dicasContent, findsOneWidget);

    // Test different screen sizes
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    await tester.pumpAndSettle();
    expect(dicasContent, findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(480, 800));
    await tester.pumpAndSettle();
    expect(dicasContent, findsOneWidget);

    // Test different locales
    await tester.binding.setLocale(const Locale('pt', 'BR'));
    await tester.pumpAndSettle();
    expect(dicasContent, findsOneWidget);

    await tester.binding.setLocale(const Locale('en', 'US'));
    await tester.pumpAndSettle();
    expect(dicasContent, findsOneWidget);
  });
}
