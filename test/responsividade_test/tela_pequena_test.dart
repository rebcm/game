import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/game.dart';

void main() {
  testGoldens('Testa responsividade em telas pequenas', (tester) async {
    final builder = DeviceBuilder()
      ..overrideSurfaceSize(const Size(320, 480))
      ..addScenario(
        widget: const MeuApp(),
        name: 'Tela pequena',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'tela_pequena');
  });
}
