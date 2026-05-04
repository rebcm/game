import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test Android 13+ permissions', (tester) async {
    final permissionStatus = await Permission.audio.status;
    if (permissionStatus.isDenied) {
      final permissionRequestResult = await Permission.audio.request();
      expect(permissionRequestResult.isGranted, true);
    } else {
      expect(permissionStatus.isGranted, true);
    }
  });
}
