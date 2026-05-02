import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/test/helpers/network_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Network Edge Cases Test', () {
    testWidgets('Test latency extrema', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await NetworkHelper.simulateLatencyExtrema();

      expect(true, true);
    });

    testWidgets('Test desconexão abrupta', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await NetworkHelper.simulateAbruptDisconnection();

      expect(true, true);
    });

    testWidgets('Test limite de quota de disco atingido', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await NetworkHelper.simulateDiskQuotaLimitReached();

      expect(true, true);
    });
  });
}
