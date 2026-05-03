import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('resolution test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.binding.window.physicalSizeTestValue = const Size(100, 100);
    await tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpAndSettle();
    expect(find.byType(MyApp), findsOneWidget);
  });
}
