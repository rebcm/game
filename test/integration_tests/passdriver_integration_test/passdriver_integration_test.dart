import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Passdriver screen test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Navigate to Passdriver screen
    // await tester.tap(find.text('Passdriver'));
    // await tester.pumpAndSettle();

    expect(find.text('Passdriver Screen'), findsOneWidget);
  });
}
