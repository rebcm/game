import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Idle animation jank test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Wait for the idle animation to start
    await tester.pump(Duration(seconds: 2));

    // Measure frame rate for 10 seconds
    final stopwatch = Stopwatch()..start();
    int frameCount = 0;
    while (stopwatch.elapsed.inSeconds < 10) {
      await tester.pump();
      frameCount++;
    }

    // Check if the frame rate is within the acceptable range
    final frameRate = frameCount / stopwatch.elapsed.inSeconds;
    expect(frameRate, greaterThanOrEqualTo(30)); // Adjust the threshold as needed
  });
}
