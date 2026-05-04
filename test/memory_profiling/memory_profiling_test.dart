import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de consumo de memória durante transição de áudio', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular transição de áudio
    // await tester.tap(find.byType(AudioButton));
    await tester.pumpAndSettle();

    // Verificar consumo de memória
    final memoryUsage = await tester.binding.memoryUsage;
    expect(memoryUsage, lessThan(200 * 1024 * 1024)); // 200 MB
  });
}
