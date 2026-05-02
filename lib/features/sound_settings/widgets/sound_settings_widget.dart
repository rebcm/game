import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sound_settings_provider.dart';

class SoundSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final soundSettings = context.watch<SoundSettingsProvider>();

    return Column(
      children: [
        Slider(
          value: soundSettings.volume,
          onChanged: (value) => soundSettings.setVolume(value),
        ),
        SwitchListTile(
          title: Text('Silenciar'),
          value: soundSettings.isMuted,
          onChanged: (value) => soundSettings.toggleMute(),
        ),
      ],
    );
  }
}
