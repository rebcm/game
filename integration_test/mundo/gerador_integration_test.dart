import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('GeradorMundo generates a chunk in the app', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final chunk = GeradorMundo.gerarChunk(0, 0);
    expect(chunk, isNotNull);
  });
}
