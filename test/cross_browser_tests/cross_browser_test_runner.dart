import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'scroll_block_test.dart' as scroll_block_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Cross Browser Tests', () {
    scroll_block_test.main();
  });
}
