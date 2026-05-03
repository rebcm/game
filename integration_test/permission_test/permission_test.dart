import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/permission_utils.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test storage permission', (tester) async {
    final permissionGranted = await PermissionUtils.requestStoragePermission();
    expect(permissionGranted, true);
  });
}
