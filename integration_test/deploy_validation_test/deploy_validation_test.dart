import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Deploy validation test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Validação de build do Flutter Web
    expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);

    // Verificação de conectividade com Cloudflare
    // Não é possível testar diretamente no Flutter, mas podemos verificar se a aplicação está funcionando corretamente
    expect(find.text('Connected to Cloudflare'), findsOneWidget);
  });
}
