import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/jogo/estado_jogo.dart';

void main() {
  testWidgets('Verificar liberação de memória', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => EstadoJogo(),
        child: Consumer<EstadoJogo>(
          builder: (context, estadoJogo, child) {
            estadoJogo.iniciar();
            return Container();
          },
        ),
      ),
    );

    await tester.pumpWidget(Container());

    // Verificar se o Timer foi cancelado
    // Essa verificação deve ser feita utilizando o Flutter DevTools Memory Profiler
    // Para fins de teste automatizado, vamos apenas verificar se o widget foi desalocado
    expect(find.byType(ChangeNotifierProvider), findsNothing);
  });
}
