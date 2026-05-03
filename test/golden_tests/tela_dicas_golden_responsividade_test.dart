import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/game/tela_dicas.dart';

void main() {
  testGoldens('Tela de dicas responsividade golden test', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: Scaffold(
          body: TelaDicas(),
        ),
      ),
    );
    await screenMatchesGolden(tester, 'tela_dicas_1080_1920');
    await tester.binding.setSurfaceSize(const Size(480, 800));
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: Scaffold(
          body: TelaDicas(),
        ),
      ),
    );
    await screenMatchesGolden(tester, 'tela_dicas_480_800');
  });
}
