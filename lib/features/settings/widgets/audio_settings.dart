import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/features/settings/providers/audio_settings_provider.dart';

class AudioSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioSettings = context.watch<AudioSettingsProvider>();

    return Column(
      children: [
        Row(
          children: [
            Text('Music'),
            Switch(
              value: audioSettings.musicEnabled,
              onChanged: (value) => audioSettings.toggleMusic(),
            ),
          ],
        ),
        Slider(
          value: audioSettings.musicVolume,
          onChanged: (value) => audioSettings.setMusicVolume(value),
        ),
        Row(
          children: [
            Text('Sound Effects'),
            Switch(
              value: audioSettings.sfxEnabled,
              onChanged: (value) => audioSettings.toggleSfx(),
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
