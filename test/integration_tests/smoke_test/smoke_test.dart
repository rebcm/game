import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await _retry(
      () async {
        await tester.pumpAndSettle();
        expect(find.text('Rebeca'), findsOneWidget);
      },
      retries: 3,
      delay: Duration(seconds: 2),
    );
  });
}

Future<void> _retry(
  Future<void> Function() action, {
  required int retries,
  required Duration delay,
}) async {
  for (int i = 0; i < retries; i++) {
    try {
      await action();
      return;
    } catch (e) {
      if (i == retries - 1) rethrow;
      await Future.delayed(delay);
    }
  }
}
