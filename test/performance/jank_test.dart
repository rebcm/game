import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Idle animation jank test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final finder = find.byType(Rebeca);
    expect(finder, findsOneWidget);

    for (var i = 0; i < 100; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    expect(tester.binding.hasPendingMicrotasks, isFalse);
  });
}
