import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  testWidgets('Testa controle de volume simultâneo', (tester) async {
    await tester.pumpWidget(MyApp());

    final volumeSlider = find.byType(Slider);
    expect(volumeSlider, findsOneWidget);

    final hardwareVolumeUpButton = find.text('Volume Up');
    final hardwareVolumeDownButton = find.text('Volume Down');

    await tester.tap(hardwareVolumeUpButton);
    await tester.pump();

    await tester.drag(volumeSlider, Offset(50, 0));
    await tester.pump();

    await tester.tap(hardwareVolumeDownButton);
    await tester.pump();

    final AudioPlayer audioPlayer = AudioPlayer();
    double? volume = await audioPlayer.getVolume();

    expect(volume, greaterThan(0.0));
    expect(volume, lessThan(1.0));
  });
}
