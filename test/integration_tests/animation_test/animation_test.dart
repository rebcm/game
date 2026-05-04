import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('animation test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final fps = await tester.binding.frameRate;
    expect(fps, greaterThanOrEqualTo(60));

    final assetLoadTime = await tester.binding.getDiagnosticInfo().firstWhere((element) => element['name'] == 'assetLoadTime');
    expect(assetLoadTime['value'], lessThan(200));

    await tester.pumpAndSettle();
  });
}
