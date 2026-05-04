import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:permission_handler/permission_handler.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar solicitação de permissão de áudio/mídia', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final status = await Permission.audio.status;
    expect(status.isGranted, true);
  });
}
