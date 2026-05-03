import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('Verificar liberação de memória com Memory Profiler', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    // Simular navegação para fora da tela com EstadoJogo
    await tester.widget<Navigator>(find.byType(Navigator)).push(
      MaterialPageRoute(builder: (context) => Scaffold()),
    );

    await tester.pumpAndSettle();

    // Verificar se a instância de EstadoJogo foi removida
    // NOTA: Isso requer análise manual com Flutter DevTools Memory Profiler
    expect(find.byType(EstadoJogo), findsNothing);
  });
}
