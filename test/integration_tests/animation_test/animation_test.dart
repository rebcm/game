import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Animação da Rebeca deve rodar a 60 FPS', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste para verificar FPS
  });

  testWidgets('Tempo de carregamento da animação não deve exceder 2 segundos', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste para verificar tempo de carregamento
  });

  testWidgets('Animação deve ser suave', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste para verificar suavidade
  });
}
