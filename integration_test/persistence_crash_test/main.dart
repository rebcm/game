import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Simular Crash de App para Validação de Persistência', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Altera o volume
    await tester.tap(find.byIcon(Icons.volume_up));
    await tester.pumpAndSettle();

    // Simula o crash do app
    await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
      'flutter/lifecycle',
      const StandardMethodCodec().encodeMethodCall(const MethodCall('AppLifecycleState.detached')),
      (ByteData? data) {},
    );

    // Reinicia o app
    await app.main();
    await tester.pumpAndSettle();

    // Verifica se o dado foi persistido
    expect(find.text('Volume Alterado'), findsOneWidget);
  });
}
