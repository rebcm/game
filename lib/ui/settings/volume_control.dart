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
  void initState() {
    super.initState();
    _audioPlayer.setVolume(_volume);
  }

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
          onChanged: (value) {
            setState(() {
              _volume = value;
              _isMuted = false;
            });
            _audioPlayer.setVolume(_volume);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mute'),
            Switch(
              value: _isMuted,
              onChanged: (value) {
                setState(() {
                  _isMuted = value;
                  if (_isMuted) {
                    _audioPlayer.setVolume(0.0);
                  } else {
                    _audioPlayer.setVolume(_volume);
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
