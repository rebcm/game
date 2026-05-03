import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:pact/pact.dart';

void main() {
  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final Pact pact = Pact('game', 'frontend');

  testWidgets('test contract', (tester) async {
    await pact.setup();
    app.main();
    await tester.pumpAndSettle();
    await pact.verify();
  });
}
