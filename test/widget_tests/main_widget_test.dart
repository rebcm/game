import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('main widget test', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
