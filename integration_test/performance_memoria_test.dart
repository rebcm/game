import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Performance and Memory Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Add performance and memory tests here
    await Future.delayed(Duration(seconds: 5));
  });
}
