import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flutter DOM validation test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.byType('flt-glass-pane'), findsOneWidget);
  });
}
