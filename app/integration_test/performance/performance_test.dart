import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('performance test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final frameTimes = <Duration>[];
    await tester.binding.watchPerformance(() async {
      for (int i = 0; i < 100; i++) {
        await tester.pump(const Duration(milliseconds: 16));
        frameTimes.add(tester.binding.renderTree.lastCompositedFrameTime);
      }
    });

    final averageFps = frameTimes.length / frameTimes.reduce((a, b) => a + b).inSeconds;
    print('Average FPS: $averageFps');
    expect(averageFps, greaterThan(30));
  });
}
