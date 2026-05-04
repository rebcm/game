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
    await tester.pumpAndSettle();

    // Localizar o slider de volume na UI
    final volumeSlider = find.byType(Slider);
    expect(volumeSlider, findsOneWidget);

    // Simular ajuste de volume via slider
    await tester.drag(volumeSlider, Offset(50, 0));
    await tester.pumpAndSettle();

    // Verificar se o volume foi ajustado corretamente
    // Implementar lógica para verificar o valor do volume
  });
}
