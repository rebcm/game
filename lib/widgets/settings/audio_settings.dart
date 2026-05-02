import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';

class AudioSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerService = context.watch<AudioPlayerService>();

    return Column(
      children: [
        Slider(
          value: audioPlayerService.volume,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: '${(audioPlayerService.volume * 100).round()}%',
          onChanged: (value) async {
            await audioPlayerService.setVolume(value);
          },
        ),
        SwitchListTile(
          title: Text('Mute'),
          value: audioPlayerService.isMuted,
          onChanged: (value) async {
            await audioPlayerService.toggleMute();
          },
        ),
      ],
    );
  }
}
