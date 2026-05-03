import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('drift simulation test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.binding.clockTestValue = DateTime(2024, 1, 1);
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    await tester.binding.clockTestValue = DateTime(2024, 1, 2);
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
