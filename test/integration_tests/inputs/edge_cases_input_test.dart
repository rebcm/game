import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'helpers/input_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test simultaneous keyboard and touch input', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await simulateSimultaneousInput(tester);
    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);
  });
}
