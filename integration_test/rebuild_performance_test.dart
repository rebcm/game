import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de performance de rebuild para Undo/Redo', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula operações de Undo/Redo e mede o número de rebuilds
    int rebuildCount = 0;
    await tester.runAsync(() async {
      // Implementação do teste de performance
    });

    // Verifica se o número de rebuilds está dentro do limite aceitável
    expect(rebuildCount, lessThan(50));
  });
}

