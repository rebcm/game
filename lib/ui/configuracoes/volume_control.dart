import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VolumeControl extends StatefulWidget {
  @override
  _VolumeControlState createState() => _VolumeControlState();
}

class _VolumeControlState extends State<VolumeControl> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double _volume = 1.0;
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _volume,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: _volume.toStringAsFixed(1),
          onChanged: (value) async {
            setState(() {
              _volume = value;
              _isMuted = value == 0.0;
            });
            await _audioPlayer.setVolume(_volume);
          },
        ),
        SwitchListTile(
          title: Text('Mute'),
          value: _isMuted,
          onChanged: (value) async {
            setState(() {
              _isMuted = value;
              _volume = value ? 0.0 : 1.0;
            });
            await _audioPlayer.setVolume(_volume);
          },
        ),
      ],
    );
  }
}
