import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/ui/dicas.dart';

void main() {
  group('UI de Dicas', () {
    testGoldens('deve renderizar corretamente em diferentes tamanhos de tela', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Dicas(),
        ),
      );

      await multiScreenGolden(tester, 'dicas_golden');
    });
  });
}
