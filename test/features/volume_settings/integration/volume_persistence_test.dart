import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:passdriver/main.dart' as app;
import 'package:passdriver/features/volume_settings/presentation/volume_settings_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('persist volume value', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byType(VolumeSettingsScreen));
    await tester.pumpAndSettle();

    final slider = find.byType(Slider);
    await tester.drag(slider, Offset(50, 0));
    await tester.pumpAndSettle();

    final value = (tester.widget(slider) as Slider).value;
    await tester.restartApp();
    await tester.pumpAndSettle();

    await tester.tap(find.byType(VolumeSettingsScreen));
    await tester.pumpAndSettle();

    final newSlider = find.byType(Slider);
    expect((tester.widget(newSlider) as Slider).value, value);
  });
}
