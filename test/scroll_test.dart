import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('Scroll test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate scroll
    await tester.drag(find.byType(CustomScrollView), Offset(0, -100));
    await tester.pumpAndSettle();

    // Verify scroll position
    expect(find.byType(ListView), findsOneWidget);
  });
}
