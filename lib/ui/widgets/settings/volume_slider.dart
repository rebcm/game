import 'package:flutter/material.dart';

class VolumeSlider extends StatefulWidget {
  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _currentVolume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentVolume,
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: _currentVolume.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentVolume = value;
        });
      },
    );
  }
}
