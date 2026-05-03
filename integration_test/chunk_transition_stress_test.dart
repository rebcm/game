import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chunk transition stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final chunkTransitionButton = find.byTooltip('Transition Chunk');
    for (var i = 0; i < 100; i++) {
      await tester.tap(chunkTransitionButton);
      await tester.pumpAndSettle(Duration(milliseconds: 50));
    }
  });
}
