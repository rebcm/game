import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chunk Stress Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate rapid chunk transitions
    for (int i = 0; i < 100; i++) {
      await tester.pump(Duration(milliseconds: 50));
      // Logic to simulate chunk change
    }

    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
