import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('audio interruption test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Start playing audio
    await tester.tap(find.byTooltip('Play Audio'));
    await tester.pumpAndSettle();

    // Simulate incoming call interruption
    await tester.binding.handlePlatformMessage(
      'flutter/platform',
      const StandardMethodCodec().encodeMethodCall(
        const MethodCall('interruption', 'incoming_call'),
      ),
      (ByteData? data) {},
    );
    await tester.pumpAndSettle();

    // Verify audio paused
    expect(find.text('Audio Paused'), findsOneWidget);

    // Resume audio after interruption
    await tester.binding.handlePlatformMessage(
      'flutter/platform',
      const StandardMethodCodec().encodeMethodCall(
        const MethodCall('resume', 'audio'),
      ),
      (ByteData? data) {},
    );
    await tester.pumpAndSettle();

    // Verify audio resumed
    expect(find.text('Audio Playing'), findsOneWidget);
  });
}
