import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:passdriver/main.dart' as app;
import 'package:passdriver/features/test_support/infra/test_app_life_cycle_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async {
    // Clear local storage
    await clearLocalStorage();
  });

  testWidgets('test description', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    // Test logic here
  });
}

Future<void> clearLocalStorage() async {
  // Implement local storage clearing logic here
  // Use existing packages from pubspec.yaml
}
