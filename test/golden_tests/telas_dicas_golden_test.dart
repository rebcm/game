import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/telas/dicas/tela_dicas.dart';

void main() {
  group('Tela de Dicas Golden Tests', () {
    testGoldens('Tela de Dicas deve corresponder ao golden', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: TelaDicas(),
        ),
        surfaceSize: Size(400, 800),
      );
      await screenMatchesGolden(tester, 'tela_dicas');
    });

    testGoldens('Tela de Dicas deve corresponder ao golden em diferentes tamanhos de tela', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            body: TelaDicas(),
          ),
        ),
      );
      await multiScreenGolden(tester, 'tela_dicas_multi_tamanho', devices: [
        Device.phone,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ]);
    });
  });
}
