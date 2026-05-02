import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  testWidgets('Renderizador Isométrico não deve rebuildar desnecessariamente', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RenderizadorIsometrico(),
      ),
    );

    final rebuildCount = tester.binding.hasWidgetRenderObjectCache();
    expect(rebuildCount, lessThan(5)); // Ajustar o valor conforme necessário
  });
}
