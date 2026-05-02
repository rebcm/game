import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/jogo/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo não deve ter memory leak', (tester) async {
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

    final estadoJogo = tester.state<EstadoJogo>(find.byType(ChangeNotifierProvider));
    expect(estadoJogo.mounted, true);

    await tester.pumpWidget(Container());

    expect(estadoJogo.mounted, false);
  });
}
