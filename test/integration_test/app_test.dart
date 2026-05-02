import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test app', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add test logic here
    expect(true, true);
  });
}
