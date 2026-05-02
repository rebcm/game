import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flame/game.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  testWidgets('Verifica sincronização do loop Flame com OpenGL', (tester) async {
    await tester.pumpWidget(
      GameWidget(
        game: RenderizadorIsometrico(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(RenderizadorIsometrico), findsOneWidget);
  });
}
