import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/dicas/dica_wrapper.dart';

void main() {
  testWidgets('DicaWrapper mostra child corretamente', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DicaWrapper(child: Text('Child')),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
  });
}
