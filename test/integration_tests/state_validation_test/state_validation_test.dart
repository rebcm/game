import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate rendering settings', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify rendering settings are applied
    expect(find.text('Rendering Settings Applied'), findsOneWidget);
  });
}
