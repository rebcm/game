import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/main.dart' as game;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Undo/Redo performance test', (tester) async {
    await game.main();
    await tester.pumpAndSettle();

    // Perform a series of Undo/Redo operations and measure rebuilds
    int initialRebuildCount = tester.binding.renderViewElement?.debugRebuildCounter ?? 0;
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Redo'));
      await tester.pumpAndSettle();
    }
    int finalRebuildCount = tester.binding.renderViewElement?.debugRebuildCounter ?? 0;
    int rebuilds = finalRebuildCount - initialRebuildCount;

    // Assert the number of rebuilds is within the acceptable baseline
    expect(rebuilds, lessThan(50)); // Baseline value, adjust as necessary
  });
}
