import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VolumeControl extends StatefulWidget {
  @override
  _VolumeControlState createState() => _VolumeControlState();
}

class _VolumeControlState extends State<VolumeControl> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double _volume = 0.5;

  void _updateVolume(double value) async {
    setState(() {
      _volume = value;
    });
    await _audioPlayer.setVolume(_volume);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _volume,
      onChanged: _updateVolume,
      min: 0.0,
      max: 1.0,
    );
  }
}
