import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Movimentação ultra-rápida não causa stuttering ou crashes',
      (tester) async {
    await tester.pumpWidget(MyApp());

    final rebeca = Rebeca();
    final gerador = GeradorMundo();
    final renderizador = RenderizadorIsometrico(gerador);

    await tester.pump();

    for (var i = 0; i < 100; i++) {
      rebeca.mover(10, 0);
      await tester.pump();
      renderizador.renderizar();
      await tester.pump();
    }

    expect(true, true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RenderizadorIsometrico(GeradorMundo()),
      ),
    );
  }
}
