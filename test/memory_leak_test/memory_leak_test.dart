import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo não deve vazar memória após dispose', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpAndSettle();

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    // Verificar se o widget foi removido da árvore de widgets
    expect(estadoJogoFinder, findsNothing);
  });
}
import 'helpers/memory_leak_helper.dart';

void main() {
  // ... (restante do código)

  testWidgets('Verificar leak de memória com MemoryLeakHelper', (tester) async {
    EstadoJogo? estadoJogo;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            estadoJogo = EstadoJogo();
            return estadoJogo!;
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    estadoJogo = null;

    // Forçar GC
    await Future.delayed(Duration(seconds: 2));

    MemoryLeakHelper.checkMemoryLeak(estadoJogo!);
  });
}
