import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Deploy test critérios aceitação', (tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });
}
