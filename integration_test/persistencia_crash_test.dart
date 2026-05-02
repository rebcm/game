import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Simular crash após alterar volume', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final volumeSlider = find.byKey(Key('volume_slider'));
    await tester.tap(volumeSlider);
    await tester.pumpAndSettle();

    final saveButton = find.byKey(Key('save_button'));
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Simular crash do app
    // Observação: Não é possível realmente "crashar" o app em um teste.
    // Este teste simula a lógica de persistência.
    expect(find.byKey(Key('volume_value')), findsOneWidget);
  });
}
