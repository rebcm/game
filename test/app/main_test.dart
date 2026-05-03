import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hello, Rebeca!'), findsOneWidget);
  });
}
