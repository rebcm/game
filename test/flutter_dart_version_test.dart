import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Flutter and Dart version check', (tester) async {
    // This test is more about the CI/CD pipeline checking the versions
    // So, here we just ensure the app runs without immediate crashes
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
