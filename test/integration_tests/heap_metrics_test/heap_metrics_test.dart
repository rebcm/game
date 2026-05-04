import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Heap metrics test', (tester) async {
    // Run the app and extract heap metrics
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
  });
}
