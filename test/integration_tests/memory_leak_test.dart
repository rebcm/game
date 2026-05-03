import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Memory leak test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Inicia o rastreamento de vazamento de memória
    await LeakTracker.start();

    // Executa ações no aplicativo para testar o vazamento de memória
    // ...

    // Para o rastreamento e verifica se houve vazamento
    final result = await LeakTracker.stop();
    expect(result.leaks, isEmpty);
  });
}

