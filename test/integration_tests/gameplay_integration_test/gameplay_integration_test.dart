import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate gameplay integration', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Validate frame rate performance
    final frameRate = await tester.binding.frameRate;
    expect(frameRate, isNotNull);
    expect(frameRate, greaterThan(0));

    // Validate input handling
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text('Button tapped'), findsOneWidget);

    // Validate trigger dicas
    final dicasTrigger = find.byKey(const Key('dicas_trigger'));
    await tester.tap(dicasTrigger);
    await tester.pumpAndSettle();
    expect(find.text('Dicas displayed'), findsOneWidget);
  });
}
