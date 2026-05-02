import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/jogo/sincronizador_frame.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('testar sincronização de frames', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final sincronizador = SincronizadorFrame();
    sincronizador.inicializar(tester.firstState(app.gameKey).widget as FlameGame);

    sincronizador.sincronizar();
    await tester.pump();

    expect(sincronizador._isFrameScheduled, false);
  });
}
