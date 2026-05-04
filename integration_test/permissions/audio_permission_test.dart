import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/services/permission_service/permission_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('request audio permission', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final permissionService = PermissionService();
    final result = await permissionService.requestAudioPermission();
    expect(result, true);
  });

  testWidgets('check audio permission', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final permissionService = PermissionService();
    final result = await permissionService.checkAudioPermission();
    expect(result, true);
  });
}
