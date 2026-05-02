import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flutter CI Test', () {
    testWidgets('Test if app launches successfully', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Rebeca'), findsOneWidget);
    });
  });
}
