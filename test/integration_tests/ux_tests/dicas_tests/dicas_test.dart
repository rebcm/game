import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/widgets/dicas/dica_wrapper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DicaWrapper exibe dica', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DicaWrapper(
        child: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                (context.findAncestorWidgetOfExactType<DicaWrapper>() as DicaWrapper).mostrarDica('Dica Teste');
              },
              child: Text('Mostrar Dica'),
            );
          },
        ),
      ),
    ));

    await tester.tap(find.text('Mostrar Dica'));
    await tester.pump();

    expect(find.text('Dica Teste'), findsOneWidget);
  });
}
