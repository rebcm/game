import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Floating point precision test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Perform actions that test floating point precision
    // For example, create a voxel at a specific position and verify its position
    // await tester.tap(find.byType(VoxelButton));
    // await tester.pumpAndSettle();
    // expect(find.byType(Voxel), findsOneWidget);
  });
}
