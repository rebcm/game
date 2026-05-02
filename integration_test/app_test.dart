import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke test', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    final fltGlassPane = find.byElementPredicate((element) => element.widget.toString().contains('flt-glass-pane'));
    expect(fltGlassPane, findsOneWidget);
  });
}
