import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test audio interruption', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // implement test logic here
  });

  testWidgets('test phone call interruption', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // implement test logic here
  });

  testWidgets('test high priority notification interruption', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // implement test logic here
  });
}
