import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('content regression test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify that the initial screen is rendered correctly
    expect(find.text('Rebeca\'s Game'), findsOneWidget);

    // Add more test steps as needed to verify content integrity
    // For example, checking specific UI elements, text, or assets
    expect(find.byType(GridView), findsOneWidget);
  });
}
