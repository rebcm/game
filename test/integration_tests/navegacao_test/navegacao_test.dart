import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navegacao entre telas', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a navegação entre telas
    final Finder botaoConfiguracoes = find.byTooltip('Configurações');
    expect(botaoConfiguracoes, findsOneWidget);
    await tester.tap(botaoConfiguracoes);
    await tester.pumpAndSettle();

    final Finder tituloConfiguracoes = find.text('Configurações');
    expect(tituloConfiguracoes, findsOneWidget);

    // Volta para a tela inicial
    final Finder botaoVoltar = find.byTooltip('Voltar');
    expect(botaoVoltar, findsOneWidget);
    await tester.tap(botaoVoltar);
    await tester.pumpAndSettle();
  });
}
