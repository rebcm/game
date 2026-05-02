import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Check Flutter View', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.byType(FlutterView), findsOneWidget);
  });
}
