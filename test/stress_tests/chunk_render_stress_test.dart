import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Chunk render stress test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    for (var i = 0; i < 1000; i++) {
      await tester.pumpAndSettle(Duration(milliseconds: 16));
    }
  });
}
