import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa interação do controle de volume com botões físicos', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula pressionamento do botão de volume para cima
    await tester.binding.platformDispatcher.handlePlatformMessage(
      'flutter/keyevent',
      const StandardMethodCodec().encodeMethodCall(const MethodCall('keydown', {
        'type': 'keydown',
        'keymap': 'android',
        'keyCode': 24, // Android key code for volume up
      })),
      (data) {},
    );

    await tester.pumpAndSettle();

    // Verifica se o volume aumentou
    expect(find.text('Volume aumentado'), findsOneWidget);

    // Simula pressionamento do botão de volume para baixo
    await tester.binding.platformDispatcher.handlePlatformMessage(
      'flutter/keyevent',
      const StandardMethodCodec().encodeMethodCall(const MethodCall('keydown', {
        'type': 'keydown',
        'keymap': 'android',
        'keyCode': 25, // Android key code for volume down
      })),
      (data) {},
    );

    await tester.pumpAndSettle();

    // Verifica se o volume diminuiu
    expect(find.text('Volume diminuído'), findsOneWidget);
  });
}
