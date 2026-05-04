import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('pseudo-localization test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simulate pseudo-localization
    await tester.binding.setLocale('pseudo');

    // Check for text wrapping/ellipsis
    await tester.pumpAndSettle();
    expect(find.text('Very long text that should be wrapped or ellipsized'), findsOneWidget);
    expect(find.byType(TextOverflow.ellipsis), findsOneWidget);
  });
}
