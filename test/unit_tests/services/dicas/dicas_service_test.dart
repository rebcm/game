import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/dicas/dicas_service.dart';

void main() {
  testWidgets('DicasService mostra dica corretamente', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) {
          DicasService().mostrarDica(context, 'Teste');
          return Container();
        },
      ),
    ));

    await tester.pump();

    expect(find.text('Teste'), findsOneWidget);
  });
}
