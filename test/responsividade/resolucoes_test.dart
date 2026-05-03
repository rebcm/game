import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('testar resoluções de tela', (tester) async {
    await tester.binding.setSurfaceSize(const Size(640, 1136));
    await tester.pumpAndSettle();
    // Adicionar assertions para verificar a renderização correta

    await tester.binding.setSurfaceSize(const Size(1080, 2244));
    await tester.pumpAndSettle();
    // Adicionar assertions para verificar a renderização correta

    await tester.binding.setSurfaceSize(const Size(2224, 1668));
    await tester.pumpAndSettle();
    // Adicionar assertions para verificar a renderização correta

    await tester.binding.setSurfaceSize(const Size(2220, 1080));
    await tester.pumpAndSettle();
    // Adicionar assertions para verificar a renderização correta
  });
}

