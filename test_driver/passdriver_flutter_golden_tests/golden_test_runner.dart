import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'golden_tests.dart' as golden_tests;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Golden Tests', () {
    golden_tests.main();
  });
}
