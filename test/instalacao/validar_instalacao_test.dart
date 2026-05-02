import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/main.dart' as app;
void main() {
  testWidgets('Counter increments smoke test', (tester) async {
    await tester.pumpWidget(app.MyApp());
  });
}
