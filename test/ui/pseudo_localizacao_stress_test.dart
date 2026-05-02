import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/ui/hud.dart';
import 'package:rebcm/ui/pseudo_localizacao.dart';

void main() {
  testWidgets('Teste de stress de layout com pseudo-localização', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HUD(),
        ),
      ),
    );

    expect(find.text(PseudoLocalizacao.traduzir('Inventário')), findsOneWidget);
  });
}
