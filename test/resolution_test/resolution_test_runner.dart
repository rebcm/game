import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('resolution test runner', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpAndSettle();
    // Add more test logic here if needed
  });
}
