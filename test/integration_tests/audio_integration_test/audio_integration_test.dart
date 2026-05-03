import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test audio playback
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pumpAndSettle();
    expect(find.text('Audio playing'), findsOneWidget);

    // Test audio pause
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pumpAndSettle();
    expect(find.text('Audio paused'), findsOneWidget);

    // Test audio stop
    await tester.tap(find.byIcon(Icons.stop));
    await tester.pumpAndSettle();
    expect(find.text('Audio stopped'), findsOneWidget);
  });
}
