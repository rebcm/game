import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:permission_handler/permission_handler.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Permission Tests', () {
    testWidgets('Test Permission Granted', (tester) async {
      await Permission.camera.request();
      await app.main();
      await tester.pumpAndSettle();
      // Implement logic to verify pipeline success
    });

    testWidgets('Test Permission Denied', (tester) async {
      await Permission.camera.request().then((value) => value.isDenied);
      await app.main();
      await tester.pumpAndSettle();
      // Implement logic to verify pipeline error 403
    });
  });
}
