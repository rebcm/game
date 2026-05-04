import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar concorrência de input de volume', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular ajuste de volume via botões físicos
    await tester.binding.platformDispatcher.hardwareVolumeChangedCallback!(0.5);

    // Localizar o slider de volume na UI
    final volumeSlider = find.byType(Slider);
    expect(volumeSlider, findsOneWidget);

    // Interagir com o slider de volume
    await tester.drag(volumeSlider, Offset(50, 0));
    await tester.pumpAndSettle();

    // Verificar se o volume foi atualizado corretamente
    // Implementar lógica para verificar o valor do volume
    // expect(volumeValue, expectedVolumeValue);
  });
}
