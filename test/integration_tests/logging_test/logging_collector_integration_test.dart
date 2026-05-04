import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/logging/logging_collector.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('LoggingCollector Integration', () {
    testWidgets('should collect log messages during app run', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      final collector = LoggingCollector();
      collector.collect('Test log message during app run');
      expect(collector.logs, contains('Test log message during app run'));
    });
  });
}
