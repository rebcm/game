import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/game.dart';

void main() {
  group('Tela de Dicas Golden Tests', () {
    testGoldens('Tela de Dicas responsividade', (tester) async {
      final widget = MaterialApp(
        home: TelaDicas(),
      );

      await tester.pumpWidgetBuilder(widget);
      await screenMatchesGolden(tester, 'tela_dicas');
    });

    testGoldens('Tela de Dicas diferentes tamanhos de tela', (tester) async {
      final widget = MaterialApp(
        home: TelaDicas(),
      );

      await tester.pumpWidgetBuilder(
        widget,
        surfaceSize: Size(400, 800),
      );
      await screenMatchesGolden(tester, 'tela_dicas_pequena');

      await tester.pumpWidgetBuilder(
        widget,
        surfaceSize: Size(800, 600),
      );
      await screenMatchesGolden(tester, 'tela_dicas_media');

      await tester.pumpWidgetBuilder(
        widget,
        surfaceSize: Size(1920, 1080),
      );
      await screenMatchesGolden(tester, 'tela_dicas_grande');
    });
  });
}
