import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chunk heterogeneous long stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implement the test logic here
    // For example, continuously render chunks and check for memory leaks
    for (int i = 0; i < 1000; i++) {
      // Render chunks
      await tester.pumpAndSettle(Duration(seconds: 1));
    }
  });
}
