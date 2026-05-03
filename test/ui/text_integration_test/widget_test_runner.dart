import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Text Integration Tests', () {
    testWidgets('Text layout test', (tester) async {
      await textLayoutTest(tester);
    });
  });
}
