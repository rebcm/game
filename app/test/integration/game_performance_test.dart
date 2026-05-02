import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Game Performance Tests', () {
    testWidgets('FPS and Jank Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();

      final binding = IntegrationTestWidgetsFlutterBinding.instance;
      final frameFuture = binding.watchPerformance(() async {
        await Future.delayed(const Duration(seconds: 10));
      });

      final performance = await frameFuture;
      final fps = performance.frameRate;
      final jankCount = performance.jankCount;

      print('FPS: $fps');
      print('Jank Count: $jankCount');

      expect(fps.average, greaterThan(30));
      expect(jankCount, lessThan(5));
    });
  });
}
