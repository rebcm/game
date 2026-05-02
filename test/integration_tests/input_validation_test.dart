import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/services/input_validator.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should validate input within character limit', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    // Simulate input and verify validation result
    final result = InputValidator.validateInput('valid_input');
    expect(result, isTrue);
  });

  testWidgets('should reject input exceeding character limit', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    // Simulate input and verify validation result
    final result = InputValidator.validateInput('a' * 256);
    expect(result, isFalse);
  });
}
