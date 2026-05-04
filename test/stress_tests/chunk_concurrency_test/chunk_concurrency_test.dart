import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Concorrência de escrita de chunks', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula múltiplos uploads simultâneos do mesmo chunk
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Salvar Chunk'));
      await tester.pump();
    }

    await tester.pumpAndSettle(Duration(seconds: 5));

    // Verifica a consistência dos dados
    expect(find.text('Chunk salvo com sucesso'), findsOneWidget);
  });
}
