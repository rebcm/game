import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/scroll_widget.dart';

void main() {
  testWidgets('scroll widget test', (tester) async {
    await tester.pumpWidget(ScrollWidget());

    // Perform scroll action
    await tester.drag(find.byType(ListView), Offset(0, -300));
    await tester.pumpAndSettle();

    // Verify scroll result
    expect(find.text('Scrolled'), findsOneWidget);
  });
}
