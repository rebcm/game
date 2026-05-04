import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:permission_handler/permission_handler.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test Android 13+ permissions', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    if (await Permission.audio.status.isDenied) {
      await Permission.audio.request();
    }

    expect(await Permission.audio.status.isGranted, true);
  });
}
