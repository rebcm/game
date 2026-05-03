import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('stress test de carregamento de chunks', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula movimentação rápida entre chunks
    for (int i = 0; i < 100; i++) {
      await tester.pump(Duration(milliseconds: 50));
      // Movimentação para simular mudança de chunk
    }

    expect(find.text('Rebeca'), findsOneWidget);
  });
}
