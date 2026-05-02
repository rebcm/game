import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);
  });
}
