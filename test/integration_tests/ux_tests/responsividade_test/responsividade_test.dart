import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Tela inicial responsiva em dispositivos pequenos', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Rebeca\'s Game'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });
}
