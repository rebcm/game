import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test dicas appearance and interaction', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate gameplay scenario where dicas should appear
    await tester.tap(find.byTooltip('Build Button'));
    await tester.pumpAndSettle();

    // Check if dicas are visible and accessible
    expect(find.text('Dica de Construção'), findsOneWidget);
    await tester.tap(find.text('Dica de Construção'));
    await tester.pumpAndSettle();

    // Verify the expected interaction flow
    expect(find.text('Construir um bloco'), findsOneWidget);
  });
}
