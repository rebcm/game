import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';

class AudioSettings extends StatefulWidget {
  @override
  _AudioSettingsState createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  @override
  Widget build(BuildContext context) {
    final audioPlayerService = Provider.of<AudioPlayerService>(context);
    return Column(
      children: [
        Slider(
          value: audioPlayerService.getVolume(),
          onChanged: (value) async {
            await audioPlayerService.setVolume(value);
            setState(() {});
          },
          min: 0.0,
          max: 1.0,
        ),
        SwitchListTile(
          title: Text('Mute'),
          value: audioPlayerService.isMuted(),
          onChanged: (value) async {
            await audioPlayerService.toggleMute();
            setState(() {});
          },
        ),
      ],
    );
  }
}
