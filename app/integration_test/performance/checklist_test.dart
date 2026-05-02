import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('checklist test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test UI transitions
    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();
    expect(find.text('Inventory'), findsOneWidget);

    // Test edge cases
    await tester.drag(find.text('Rebeca'), Offset(100, 100));
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
