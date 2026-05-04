import 'package:integration_test/integration_test.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionBinding extends IntegrationTestWidgetsFlutterBinding {
  @override
  Future<void> runTest(Future<void> test()) async {
    await Permission.audio.request();
    await super.runTest(test);
  }
}
