import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de stress de input', (tester) async {
    await tester.pumpWidget(Rebeca());

    final renderizador = RenderizadorIsometrico();
    await renderizador.inicializar();

    for (int i = 0; i < 100; i++) {
      await tester.pump(const Duration(milliseconds: 16)); // 60 FPS
      Rebeca.velocidade = 0;
      await tester.pump(const Duration(milliseconds: 1));
      Rebeca.velocidade = 10;
      await tester.pump(const Duration(milliseconds: 1));
      expect(renderizador.frame, isNotNull);
    }
  });
}
