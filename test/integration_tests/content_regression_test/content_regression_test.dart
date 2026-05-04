import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('content regression test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify that the initial screen is rendered correctly
    expect(find.text('Rebeca'), findsOneWidget);

    // Test various UI elements and their content
    expect(find.text('Build Mode'), findsOneWidget);
    expect(find.text('Creative Mode'), findsOneWidget);

    // Add more test cases as needed to cover different content aspects
  });
}
