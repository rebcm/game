import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Rebuild Performance Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular operações de Undo/Redo
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.byIcon(Icons.undo));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.redo));
      await tester.pumpAndSettle();
    }

    // Coletar resultados
    final results = {
      'rebuilds': tester.binding.renderViewElement?.debugRebuildCount,
      'latency': tester.binding.renderViewElement?.debugRebuildDuration.inMilliseconds,
    };

    // Salvar resultados em um arquivo
    final file = File('rebuild_performance_test_results.json');
    await file.writeAsString(jsonEncode(results));
  });
}

