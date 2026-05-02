import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/gestures/gestures.dart';
void main() {
  testWidgets('GestureDetector test', (tester) async {
    await tester.pumpWidget(Gestures());
    expect(find.byType(GestureDetector), findsOneWidget);
  });
}
