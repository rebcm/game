import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('documentacao test', (tester) async {
    // Implement the test logic here
    await tester.pumpAndSettle();
    expect(true, true);
  });
}
