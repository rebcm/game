import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/ui/testes/documentacao_controles.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('testa documentação de controles', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rebeca'));
    await tester.pumpAndSettle();

    expect(find.byType(HUD), findsOneWidget);
  });

  testWidgets('testa edge case de controles', (tester) async {
    await tester.pumpWidget(DocumentacaoControles());
    await tester.pumpAndSettle();

    expect(find.byType(HUD), findsOneWidget);
  });
}
