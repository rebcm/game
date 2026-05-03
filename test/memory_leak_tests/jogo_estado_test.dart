import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Verifica se EstadoJogo é removido da memória após dispose', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EstadoJogo()),
        ],
        child: Container(),
      ),
    );

    final estadoJogo = Provider.of<EstadoJogo>(tester.element(find.byType(Container)), listen: false);

    expect(estadoJogo.mounted, true);

    await tester.pumpWidget(Container());

    expect(() => Provider.of<EstadoJogo>(tester.element(find.byType(Container)), listen: false), throwsError);
  });
}
