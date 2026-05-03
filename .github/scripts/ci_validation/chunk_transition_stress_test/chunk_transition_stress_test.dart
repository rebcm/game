import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chunk transition stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate rapid chunk transitions
    for (int i = 0; i < 100; i++) {
      await tester.drag(find.byType(GridView), Offset(100, 0));
      await tester.pumpAndSettle(Duration(milliseconds: 50));
    }

    // Verify FPS performance
    expect(tester.binding.frameInterval, lessThan(Duration(milliseconds: 16)));
  });
}
