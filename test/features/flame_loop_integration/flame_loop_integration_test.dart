import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/flame_loop_integration/widgets/flame_loop_integration_widget.dart';

void main() {
  testWidgets('Flame loop integration test', (tester) async {
    await tester.pumpWidget(FlameLoopIntegrationWidget());
    await tester.pumpAndSettle();
    expect(find.byType(FlameLoopIntegrationWidget), findsOneWidget);
  });
}
