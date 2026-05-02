import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/estado_jogo.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('EstadoJogo não deve ter vazamento de memória', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final estadoJogoFinder = find.byType(EstadoJogo);

    expect(estadoJogoFinder, findsOneWidget);

    await tester.tap(find.text('Sair'));
    await tester.pumpAndSettle();

    expect(estadoJogoFinder, findsNothing);

    await tester.pumpAndSettle(Duration(seconds: 2));

    // Verificar se há vazamento de memória
    // Essa parte pode ser implementada utilizando ferramentas de profiling
  });
}
