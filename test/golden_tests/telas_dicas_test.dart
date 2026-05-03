import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('Tela de Dicas', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: app.TelaDicas(),
      ),
    );

    await screenMatchesGolden(tester, 'tela_dicas_golden');
  });

  testGoldens('Tela de Dicas - Diferentes Tamanhos de Tela', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: app.TelaDicas(),
      ),
    );

    await tester.binding.window.physicalSizeTestValue = Size(400, 800);
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'tela_dicas_golden_400x800');

    await tester.binding.window.physicalSizeTestValue = Size(800, 600);
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'tela_dicas_golden_800x600');
  });
}
