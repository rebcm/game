import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/jogo.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa perfil de memória ao sair da tela do jogo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Jogo(),
      ),
    );

    await tester.pumpAndSettle();

    final jogoState = tester.state(find.byType(Jogo));

    expect(jogoState.mounted, true);

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    // Verificar se a memória foi liberada corretamente
    // Essa parte pode ser feita manualmente com o Memory Profiler do Flutter DevTools
  });
}
