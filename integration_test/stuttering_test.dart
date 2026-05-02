import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('stuttering test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final testDuration = int.parse(const String.fromEnvironment('test_duration'));
    final fpsThreshold = int.parse(const String.fromEnvironment('fps_threshold'));

    await tester.pump(Duration(seconds: testDuration));

    final frameStats = await tester.binding.frameStats;
    final fps = frameStats.map((e) => e.fps).reduce((a, b) => a + b) / frameStats.length;

    expect(fps, greaterThanOrEqualTo(fpsThreshold));
  });
}
