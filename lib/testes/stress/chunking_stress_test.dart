import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  testWidgets('Teste de estresse de chunking', (tester) async {
    await tester.pumpWidget(MyApp());
    final rebeca = tester.widget<Rebeca>(find.byType(Rebeca));
    final gerador = GeradorMundo();

    for (var i = 0; i < 100; i++) {
      rebeca.x += 10;
      await tester.pump();
      gerador.gerarChunk(rebeca.x ~/ 16, rebeca.z ~/ 16);
      await tester.pump();
    }

    expect(find.byType(RenderizadorIsometrico), rendersProperly);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RenderizadorIsometrico(),
      ),
    );
  }
}
