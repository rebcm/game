import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('rendering test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final finder = find.byType('TextureWidget'); // Assuming TextureWidget is used to render the texture
    expect(finder, findsOneWidget);
    // Add more expectations to verify the rendering quality
  });
}
