import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/audio/audio_manager.dart';

class VolumeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioManager = Provider.of<AudioManager>(context);
    return Slider(
      value: 0.5, // Default volume
      min: 0.0,
      max: 1.0,
      onChanged: (value) async {
        await audioManager.setVolume(value);
      },
    );
  }
}
