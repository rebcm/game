import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa leak de memória ao descartar estado_jogo', (tester) async {
    await tester.pumpWidget(MyApp());

    final estadoJogo = tester.state(find.byType(EstadoJogo));

    expect(estadoJogo.mounted, true);

    await tester.pumpAndSettle();

    Navigator.of(tester.element(find.byType(EstadoJogo))).pushReplacementNamed('/outra_tela');

    await tester.pumpAndSettle();

    expect(estadoJogo.mounted, false);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste de Leak de Memória',
      home: EstadoJogo(),
      routes: {
        '/outra_tela': (context) => Scaffold(),
      },
    );
  }
}
