import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('input test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();
    expect(find.byType(MyApp), findsOneWidget);
  });
}
