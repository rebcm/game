import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Testa interação do controle de volume com slider',
      (WidgetTester tester) async {
    await tester.pumpWidget(app.RebecaApp());

    // Encontra o slider de volume
    final volumeSlider = find.byType(Slider);

    // Move o slider para cima
    await tester.drag(volumeSlider, const Offset(0, -100));

    await tester.pumpAndSettle();

    // Verifica se o volume aumentou
    expect(find.text('Volume aumentou'), findsOneWidget);

    // Move o slider para baixo
    await tester.drag(volumeSlider, const Offset(0, 100));

    await tester.pumpAndSettle();

    // Verifica se o volume diminuiu
    expect(find.text('Volume diminuiu'), findsOneWidget);
  });
}
