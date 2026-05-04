import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cenário 1: Usuário novo compreende a dica', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementar lógica para verificar se o usuário compreende a dica
    expect(find.text('Dica compreendida'), findsOneWidget);
  });

  testWidgets('Cenário 2: Usuário experiente ignora a dica', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementar lógica para verificar se o jogo continua normalmente
    expect(find.text('Jogo continuando'), findsOneWidget);
  });

  testWidgets('Cenário 3: Usuário clica na dica múltiplas vezes', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementar lógica para verificar se a dica não é exibida novamente
    expect(find.text('Dica não exibida novamente'), findsOneWidget);
  });
}

