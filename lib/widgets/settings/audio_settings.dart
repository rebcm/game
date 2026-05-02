import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_service.dart';

class AudioSettings extends StatefulWidget {
  @override
  _AudioSettingsState createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _volume = context.read<AudioServiceImpl>().getVolume();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _volume,
          onChanged: (value) async {
            await context.read<AudioServiceImpl>().setVolume(value);
            setState(() => _volume = value);
          },
        ),
        ElevatedButton(
          onPressed: () async {
            await context.read<AudioServiceImpl>().toggleMute();
            setState(() => _volume = context.read<AudioServiceImpl>().getVolume());
          },
          child: Text(_volume == 0 ? 'Unmute' : 'Mute'),
        ),
      ],
    );
  }
}
