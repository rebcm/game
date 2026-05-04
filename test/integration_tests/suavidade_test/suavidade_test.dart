import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('teste de suavidade', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verificar FPS
    // Verificar transição de blocos
    // Verificar movimentação da Rebeca
  });
}
