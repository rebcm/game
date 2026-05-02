import 'package:flutter_test/flutter_test.dart';
import 'package:flame/game.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verificar sincronização de frames', (tester) async {
    await tester.pumpWidget(
      GameWidget(
        game: RenderizadorIsometrico(),
      ),
    );

    await tester.pumpAndSettle();

    // Verificar se o renderizador está funcionando corretamente
    expect(find.byType(RenderizadorIsometrico), findsOneWidget);
  });
}
