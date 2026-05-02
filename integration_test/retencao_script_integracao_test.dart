import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test retenção script', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implementação do teste de retenção
    expect(true, true); // Placeholder, deve ser substituído por testes reais
  });
}
