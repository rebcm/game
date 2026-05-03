import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de vazamento de memória', (tester) async {
    // Inicializa o aplicativo
    await tester.pumpWidget(MyApp());

    // Simula a navegação para a tela do jogo
    await tester.tap(find.text('Iniciar Jogo'));
    await tester.pumpAndSettle();

    // Coleta o baseline de memória antes da destruição do estado do jogo
    final initialMemoryUsage = MemoryInfo.currentHeapSize;

    // Simula a destruição do estado do jogo
    await tester.tap(find.text('Sair do Jogo'));
    await tester.pumpAndSettle();

    // Coleta o baseline de memória após a destruição do estado do jogo
    final finalMemoryUsage = MemoryInfo.currentHeapSize;

    // Verifica se houve vazamento de memória
    expect(finalMemoryUsage - initialMemoryUsage, lessThan(1024 * 1024)); // 1MB
  });
}
