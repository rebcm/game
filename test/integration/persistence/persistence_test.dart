import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('persistência de metadados e arquivos', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula ação para persistir metadados e arquivos
    // ...

    // Verifica se os metadados e arquivos foram persistidos corretamente
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('metadados'), isNotNull);

    // Limpa dados para evitar efeitos colaterais em outros testes
    await prefs.clear();
  });
}
