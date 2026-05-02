import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Flutter Web Build Test', (tester) async {
    await tester.pumpWidget(app.MyApp());
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
