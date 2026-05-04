import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Animação da Rebeca', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verificar FPS mínimo
    // Verificar tempo de carregamento máximo
    // Verificar suavidade
    // Verificar conformidade com o design
  });
}

