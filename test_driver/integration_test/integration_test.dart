import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/main/bindings/permission_binding_wrapper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration tests', () {
    testWidgets('Run main app', (tester) async {
      app.main();
      await tester.pumpAndSettle();
    });

    testWidgets('Permission binding test', (tester) async {
      runPermissionBinding();
      await tester.pumpAndSettle();
    });
  });
}
