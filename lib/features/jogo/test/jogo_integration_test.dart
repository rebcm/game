import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:passdriver/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('jogo integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implement test logic here
  });
}
