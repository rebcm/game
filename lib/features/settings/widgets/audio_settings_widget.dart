import 'package:flutter/material.dart';
import 'package:game/features/settings/models/audio_settings.dart';
import 'package:provider/provider.dart';

class AudioSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioSettings = Provider.of<AudioSettings>(context);

    return Column(
      children: [
        Row(
          children: [
            Text('Música'),
            Switch(
              value: audioSettings.isMusicMuted,
              onChanged: (value) => audioSettings.toggleMusicMute(),
            ),
          ],
        ),
        Slider(
          value: audioSettings.musicVolume,
          onChanged: (value) => audioSettings.setMusicVolume(value),
        ),
        Row(
          children: [
            Text('Efeitos Sonoros'),
            Switch(
              value: audioSettings.isSfxMuted,
              onChanged: (value) => audioSettings.toggleSfxMute(),
            ),
          ],
        ),
        Slider(
          value: audioSettings.sfxVolume,
          onChanged: (value) => audioSettings.setSfxVolume(value),
        ),
      ],
    );
  }
}
