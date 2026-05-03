import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de Stress de Alternância Rápida', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(app.MyApp));
    final playerController = context.findAncestorWidgetOfExactType<app.PlayerController>();

    expect(playerController, isNotNull);

    for (int i = 0; i < 100; i++) {
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pump(Duration(milliseconds: 50));
      await tester.tap(find.byIcon(Icons.pause));
      await tester.pump(Duration(milliseconds: 50));
    }

    await tester.pumpAndSettle();
  });
}
