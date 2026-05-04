import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Smoke test with retry', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await retry(
      () async {
        expect(find.text('Rebeca'), findsOneWidget);
      },
      retryCount: 3,
      delay: const Duration(seconds: 2),
    );
  });
}

Future<void> retry(
  Future<void> Function() operation, {
  required int retryCount,
  required Duration delay,
}) async {
  for (int attempt = 0; attempt < retryCount; attempt++) {
    try {
      await operation();
      return;
    } catch (e) {
      if (attempt == retryCount - 1) rethrow;
      await Future.delayed(delay * (attempt + 1));
    }
  }
}
