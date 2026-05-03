import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/dicas/dica_wrapper.dart';

void main() {
  testWidgets('Deve exibir dica corretamente', (tester) async {
    // Implementar teste para DicaWrapper
    // Verificar se a dica é exibida corretamente
    await tester.pumpWidget(
      MaterialApp(
        home: DicaWrapper(
          child: const Text('Child'),
          dica: 'Dica de teste',
        ),
      ),
    );
    expect(find.text('Dica de teste'), findsOneWidget);
  });
}
