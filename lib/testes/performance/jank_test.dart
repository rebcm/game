import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  testWidgets('Animação idle não causa jank', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RenderizadorIsometrico(
            rebeca: Rebeca(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final initialFps = tester.binding.frameRate;

    await tester.pump(const Duration(seconds: 10));

    final finalFps = tester.binding.frameRate;

    expect(finalFps, greaterThanOrEqualTo(initialFps * 0.9));
  });
}
