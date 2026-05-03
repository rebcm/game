import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('resolution change test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    await tester.binding.window.physicalSizeTestValue = const Size(800, 600);
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
