import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({super.key});

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _currentVolume = 1.0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentVolume,
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: _currentVolume.toStringAsFixed(1),
      onChanged: (double value) async {
        setState(() {
          _currentVolume = value;
        });
        await AudioPlayer.global.setVolume(_currentVolume);
      },
    );
  }
}
