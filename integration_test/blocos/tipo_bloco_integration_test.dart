import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TipoBloco is used in the app', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text(TipoBloco.grama.nome), findsOneWidget);
  });
}
