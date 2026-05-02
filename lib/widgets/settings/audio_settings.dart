import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';

class AudioSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerService = Provider.of<AudioPlayerService>(context);

    return Column(
      children: [
        Slider(
          value: audioPlayerService.volume,
          onChanged: (value) async {
            await audioPlayerService.setVolume(value);
          },
          min: 0.0,
          max: 1.0,
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
