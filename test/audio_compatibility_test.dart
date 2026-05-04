import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa reprodução de áudio', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste de reprodução de áudio
  });

  testWidgets('Testa ajuste de volume', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste de ajuste de volume
  });
}

