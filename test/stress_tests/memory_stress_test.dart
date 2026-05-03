import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as game_main;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory Stress Test', (tester) async {
    await game_main.main();
    await tester.pumpAndSettle();

    for (int i = 0; i < 100; i++) {
      await tester.fling(find.byType(GridView), Offset(0, -500), 1000);
      await tester.pumpAndSettle();
    }

    expect(find.byType(GridView), findsOneWidget);
  });
}
