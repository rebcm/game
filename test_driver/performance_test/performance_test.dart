import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa tempo de inicialização do app', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementar lógica para medir o tempo de inicialização
  });
}
