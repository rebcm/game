import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'browser_tests/scroll_block_test.dart' as scroll_block_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  scroll_block_test.main();
}
