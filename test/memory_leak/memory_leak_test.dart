import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:your_app/main.dart' as app;

void main() {
  testWidgets('Memory leak test', (tester) async {
    await tester.pumpWidget(app.MyApp());

    // Start tracking memory leaks
    await LeakTracking.start();

    // Navigate to the jogo state
    await tester.tap(find.text('Jogo'));
    await tester.pumpAndSettle();

    // Get the initial memory snapshot
    final initialSnapshot = await LeakTracking.getSnapshot();

    // Destroy the jogo state
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    // Get the final memory snapshot
    final finalSnapshot = await LeakTracking.getSnapshot();

    // Check for memory leaks
    final leaks = finalSnapshot.objects
        .where((object) => !initialSnapshot.objects.contains(object))
        .toList();

    expect(leaks, isEmpty);
  });
}
