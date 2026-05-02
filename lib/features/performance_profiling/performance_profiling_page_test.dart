import 'package:flutter_test/flutter_test.dart';
import 'package:performance_profiling/performance_profiling_page.dart';

void main() {
  testWidgets('Performance Profiling Page', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Toggle Performance Overlay'), findsOneWidget);
  });
}
