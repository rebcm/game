import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test responsividade em telas pequenas', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpAndSettle();

    expect(find.text('Dicas'), findsOneWidget);
    expect(find.text('Construção'), findsOneWidget);
  });
}
