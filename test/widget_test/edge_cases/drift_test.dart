import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('drift simulation test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.drag(find.byType(MyHomePage), const Offset(100, 0));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
