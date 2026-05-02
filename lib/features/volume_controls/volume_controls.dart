import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/volume_controls/providers/volume_controls_provider.dart';

class VolumeControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final volumeControlsProvider = context.watch<VolumeControlsProvider>();

    return Column(
      children: [
        Slider(
          value: volumeControlsProvider.masterVolume,
          onChanged: (value) async {
            await volumeControlsProvider.setMasterVolume(value);
          },
          label: 'Volume Geral',
        ),
        Slider(
          value: volumeControlsProvider.musicVolume,
          onChanged: (value) async {
            await volumeControlsProvider.setMusicVolume(value);
          },
          label: 'Volume Músicas',
        ),
        Slider(
          value: volumeControlsProvider.effectsVolume,
          onChanged: (value) async {
            await volumeControlsProvider.setEffectsVolume(value);
          },
          label: 'Volume Efeitos',
        ),
      ],
    );
  }
}
