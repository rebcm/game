import Intl.message('package:flutter/material.dart');
import Intl.message('package:provider/provider.dart');
import Intl.message('../providers/sound_settings_provider.dart');

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
          title: Text(Intl.message('Silenciar')),
          value: soundSettings.isMuted,
          onChanged: (value) => soundSettings.toggleMute(),
        ),
      ],
    );
  }
}
