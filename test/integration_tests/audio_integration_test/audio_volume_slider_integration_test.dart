import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate audio volume slider integration', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find the volume sliders
    final generalVolumeSlider = find.byKey(const Key('general_volume_slider'));
    final musicVolumeSlider = find.byKey(const Key('music_volume_slider'));
    final effectsVolumeSlider = find.byKey(const Key('effects_volume_slider'));

    expect(generalVolumeSlider, findsOneWidget);
    expect(musicVolumeSlider, findsOneWidget);
    expect(effectsVolumeSlider, findsOneWidget);

    // Test the volume sliders
    await tester.drag(generalVolumeSlider, const Offset(50, 0));
    await tester.pumpAndSettle();

    await tester.drag(musicVolumeSlider, const Offset(50, 0));
    await tester.pumpAndSettle();

    await tester.drag(effectsVolumeSlider, const Offset(50, 0));
    await tester.pumpAndSettle();
  });
}
