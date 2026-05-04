import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Renderização de tabelas em resoluções mobile', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.binding.setSurfaceSize(const Size(375, 812)); // iPhone 12 dimensions
    await tester.pumpAndSettle();
    expect(find.text('Tabela renderizada'), findsOneWidget);
  });

  testWidgets('Renderização de blocos de código em resoluções tablet', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.binding.setSurfaceSize(const Size(1024, 768)); // iPad dimensions
    await tester.pumpAndSettle();
    expect(find.text('Bloco de código renderizado'), findsOneWidget);
  });

  testWidgets('Verificação de overflow em elementos complexos de Markdown', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.binding.setSurfaceSize(const Size(375, 812)); // iPhone 12 dimensions
    await tester.pumpAndSettle();
    expect(find.byType(OverflowError), findsNothing);
  });
}
