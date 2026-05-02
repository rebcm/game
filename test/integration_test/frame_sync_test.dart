import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar sincronização de frames', (tester) async {
    await tester.pumpWidget(
      GameWidget(
        game: RenderizadorIsometrico(),
      ),
    );

    await tester.pumpAndSettle();

    // Verificar se a renderização está sincronizada corretamente
    // ...
  });
}
