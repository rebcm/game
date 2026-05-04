import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/services/permission_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final permissionService = PermissionService();
    final hasPermission = await permissionService.requestAudioPermission();
    expect(hasPermission, true);
  });
}
import 'package:game/volume_test/volume_test.dart' as volume_test;

void main() {
  volume_test.main();
  // Other integration tests...
}
