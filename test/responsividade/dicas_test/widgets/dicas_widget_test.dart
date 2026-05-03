import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/docs/dicas_template/template.dart';

void main() {
  testWidgets('Verifica se as dicas são exibidas corretamente', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DicasTemplate(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final dicasWidget = find.byType(DicasTemplate);
    expect(dicasWidget, findsOneWidget);
  });
}
