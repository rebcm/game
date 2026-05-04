import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/logs/log_screen.dart';

void main() {
  testWidgets('LogScreen has a title', (tester) async {
    await tester.pumpWidget(MaterialApp(home: LogScreen()));
    expect(find.text('Logs'), findsOneWidget);
  });
}
