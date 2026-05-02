import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';

class AudioSettings extends StatefulWidget {
  @override
  _AudioSettingsState createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  double _volume = 1.0;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _audioPlayerService.init().then((_) {
      setState(() {
        _volume = _audioPlayerService._volume;
        _isMuted = _audioPlayerService._isMuted;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _volume,
          onChanged: (value) async {
            await _audioPlayerService.setVolume(value);
            setState(() {
              _volume = value;
            });
          },
        ),
        Switch(
          value: _isMuted,
          onChanged: (value) async {
            await _audioPlayerService.toggleMute();
            setState(() {
              _isMuted = value;
            });
          },
        ),
      ],
    );
  }
}
