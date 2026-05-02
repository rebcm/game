import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_control_provider.dart';

class VolumeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioControlProvider>(
      builder: (context, provider, child) {
        return Slider(
          value: provider.volume,
          onChanged: (value) => provider.setVolume(value),
          min: 0.0,
          max: 1.0,
        );
      },
    );
  }
}
