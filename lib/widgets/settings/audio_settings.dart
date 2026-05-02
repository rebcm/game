import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_service.dart';

class AudioSettings extends StatefulWidget {
  @override
  _AudioSettingsState createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  double _volume = 1.0;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _volume = context.read<AudioServiceImpl>().getVolume();
    _isMuted = context.read<AudioServiceImpl>().isMuted();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _volume,
          onChanged: (value) async {
            await context.read<AudioServiceImpl>().setVolume(value);
            setState(() {
              _volume = value;
              _isMuted = value == 0;
            });
          },
        ),
        SwitchListTile(
          title: Text('Mute'),
          value: _isMuted,
          onChanged: (value) async {
            await context.read<AudioServiceImpl>().setMute(value);
            setState(() {
              _isMuted = value;
              _volume = value ? 0 : 1;
            });
          },
        ),
      ],
    );
  }
}
