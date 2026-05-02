import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Idle animation stress test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rebeca'));
    await tester.pumpAndSettle();
    for (var i = 0; i < 100; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
  });
}
