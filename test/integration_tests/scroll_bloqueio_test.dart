import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Bloqueio de scroll via WASD/Espaço funciona', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula pressionamento de teclas e verifica se o scroll é bloqueado
    await tester.sendKeyEvent(LogicalKeyboardKey.keyW);
    await tester.pumpAndSettle();
    // Adicione aqui as verificações necessárias

    await tester.sendKeyEvent(LogicalKeyboardKey.keyA);
    await tester.pumpAndSettle();
    // Adicione aqui as verificações necessárias

    await tester.sendKeyEvent(LogicalKeyboardKey.keyS);
    await tester.pumpAndSettle();
    // Adicione aqui as verificações necessárias

    await tester.sendKeyEvent(LogicalKeyboardKey.keyD);
    await tester.pumpAndSettle();
    // Adicione aqui as verificações necessárias

    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    // Adicione aqui as verificações necessárias
  });
}
