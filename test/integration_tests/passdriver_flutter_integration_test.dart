import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('passdriver flutter integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add integration test logic here
  });
}
