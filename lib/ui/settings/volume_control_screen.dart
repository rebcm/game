import 'package:flutter/material.dart';
import 'package:game/utils/audio/volume_controller.dart';

class VolumeControlScreen extends StatefulWidget {
  @override
  _VolumeControlScreenState createState() => _VolumeControlScreenState();
}

class _VolumeControlScreenState extends State<VolumeControlScreen> {
  double _currentVolume = VolumeController.instance.currentVolume;
  bool _isMuted = VolumeController.instance.isMuted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _currentVolume,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: _currentVolume.round().toString(),
          onChanged: (value) {
            setState(() {
              _currentVolume = value;
              VolumeController.instance.setVolume(value);
            });
          },
        ),
        SwitchListTile(
          title: Text('Mute'),
          value: _isMuted,
          onChanged: (value) {
            setState(() {
              _isMuted = value;
              VolumeController.instance.toggleMute();
            });
          },
        ),
      ],
    );
  }
}
