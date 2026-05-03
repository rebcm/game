import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test responsividade tela pequena', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula um dispositivo com largura inferior a 320dp
    tester.binding.window.physicalSizeTestValue = Size(300, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpAndSettle();

    // Verifica se as dicas estão sendo exibidas corretamente
    expect(find.text('Dica 1'), findsOneWidget);
    expect(find.text('Dica 2'), findsOneWidget);

    // Verifica se as dicas estão sendo truncadas corretamente
    expect(tester.getSize(find.text('Dica muito longa que deve ser truncada')).width, lessThan(200));
  });
}
