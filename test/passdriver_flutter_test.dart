import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('passdriver flutter test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add test logic here
  });
}
