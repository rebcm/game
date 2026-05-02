import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Plugin compatibility test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
