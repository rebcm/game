import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verificar versão do Flutter', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementar lógica para verificar a versão do Flutter
    // e sua compatibilidade com o Java 17
  });
}
