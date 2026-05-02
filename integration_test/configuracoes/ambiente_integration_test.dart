import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testes de Integração de Configurações de Ambiente', () {
    testWidgets('Verifica se o ambiente é renderizado corretamente', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Rebeca Alves Moreira'), findsOneWidget);
    });
  });
}
