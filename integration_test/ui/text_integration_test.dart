import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/test/ui/text_integration_test/text_layout_test.dart' as text_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Text Integration Tests', () {
    testWidgets('Text layout test', text_test.main);
  });
}
