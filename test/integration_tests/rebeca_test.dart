import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Rebeca test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
