import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Valida bloqueio de scroll em diferentes navegadores', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula evento de scroll
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pumpAndSettle();

    // Verifica se o scroll foi bloqueado
    expect(find.text('Scroll bloqueado'), findsOneWidget);
  });
}
