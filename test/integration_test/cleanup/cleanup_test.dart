import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/services/storage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cleanup test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Remove registros do D1
    await StorageService.deleteAllRecords();

    // Remover objetos do R2
    // Implemente a lógica para remover objetos do R2

    expect(true, true);
  });
}
