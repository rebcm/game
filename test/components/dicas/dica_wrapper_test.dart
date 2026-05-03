import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/components/dicas/dica_wrapper.dart';

void main() {
  testWidgets('DicaWrapper exibe tooltip corretamente', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DicaWrapper(
          dica: 'Dica de teste',
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Botão'),
          ),
        ),
      ),
    );

    final tooltipFinder = find.byType(Tooltip);
    expect(tooltipFinder, findsOneWidget);

    final tooltip = tester.widget<Tooltip>(tooltipFinder);
    expect(tooltip.message, 'Dica de teste');
  });
}
