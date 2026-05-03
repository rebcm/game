import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Timers stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Jogar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Voltar'));
      await tester.pumpAndSettle();
    }
  });
}
