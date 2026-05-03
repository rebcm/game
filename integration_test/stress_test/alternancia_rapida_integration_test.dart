import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as game_main;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de Stress de Alternância Rápida', (tester) async {
    await game_main.main();
    await tester.pumpAndSettle();

    final player = find.byKey(const Key('player'));

    expect(player, findsOneWidget);

    for (var i = 0; i < 100; i++) {
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.byIcon(Icons.pause));
      await tester.pump(const Duration(milliseconds: 50));
    }

    await tester.pumpAndSettle();

    expect(player, findsOneWidget);
  });
}
