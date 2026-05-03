import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test app launch', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Rebeca Alves Moreira'), findsOneWidget);
  });
}
