import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/mundo/chunk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chunking stress test', (tester) async {
    await tester.pumpWidget(MyApp());

    final geradorMundo = GeradorMundo();
    final renderizador = RenderizadorIsometrico(geradorMundo);

    for (int i = 0; i < 100; i++) {
      await tester.pump();
      renderizador.atualizarCamera(10, 0);
      await tester.pump();
    }

    expect(renderizador.chunksVisiveis.length, lessThan(10));
  });
}
